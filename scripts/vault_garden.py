#!/usr/bin/env python3
"""
Vault Gardening Script
Performs daily maintenance on the Obsidian vault to ensure content quality.
"""

import os
import re
import sys
from datetime import datetime, timedelta
from pathlib import Path
from dataclasses import dataclass, field
from typing import List, Dict, Set, Optional
import subprocess


VAULT_DIR = Path("/Users/julien/Documents/Obsidian")
STALE_DAYS = 30


@dataclass
class Note:
    """Represents a markdown note in the vault."""
    path: Path
    content: str = ""
    frontmatter: Dict = field(default_factory=dict)
    wikilinks: List[str] = field(default_factory=list)
    
    def __post_init__(self):
        if not self.content:
            self.content = self.path.read_text(encoding='utf-8')
        self._parse_frontmatter()
        self._extract_wikilinks()
    
    def _parse_frontmatter(self):
        """Extract YAML frontmatter from note content."""
        if self.content.startswith('---'):
            parts = self.content.split('---', 2)
            if len(parts) >= 3:
                import yaml
                try:
                    self.frontmatter = yaml.safe_load(parts[1]) or {}
                except yaml.YAMLError:
                    pass
    
    def _extract_wikilinks(self):
        """Extract all [[wikilinks]] from content."""
        pattern = r'\[\[([^\]]+)\]\]'
        self.wikilinks = re.findall(pattern, self.content)
    
    @property
    def title(self) -> str:
        """Get note title from filename."""
        return self.path.stem
    
    @property
    def modified_date(self) -> datetime:
        """Get last modification date."""
        stat = self.path.stat()
        return datetime.fromtimestamp(stat.st_mtime)


class VaultGarden:
    """Main gardening routine for the Obsidian vault."""
    
    def __init__(self, vault_dir: Path = VAULT_DIR):
        self.vault_dir = vault_dir
        self.notes: List[Note] = []
        self.inbox_items: List[Path] = []
        self.orphans: Dict[str, List[Note]] = {
            'projects': [],
            'areas': [],
            'ideas': [],
            'people': []
        }
        self.stale_projects: List[Note] = []
        self.new_git_files: List[str] = []
        self.frontmatter_issues: List[Dict] = []
        
    def run(self) -> Dict:
        """Run the complete gardening routine."""
        print("🌱 Starting Vault Gardening\n")
        
        self.sync_git()
        self.check_inbox()
        self.find_orphans()
        self.find_stale_projects()
        self.validate_frontmatter()
        self.check_projects_board()
        
        return self.generate_report()
    
    def sync_git(self):
        """Sync with git and identify new files."""
        print("## Git Sync")
        
        git_dir = self.vault_dir / ".git"
        if not git_dir.exists():
            print("⚠️  Not a git repository. Skipping git sync.\n")
            return
        
        try:
            # Fetch latest
            subprocess.run(
                ["git", "fetch", "origin"],
                cwd=self.vault_dir,
                capture_output=True,
                check=True
            )
            
            # Get new files since last run
            result = subprocess.run(
                ["git", "diff", "--name-only", "HEAD@{1}", "HEAD"],
                cwd=self.vault_dir,
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                files = [f for f in result.stdout.strip().split('\n') if f.endswith('.md')]
                self.new_git_files = files
                
                if files:
                    print(f"📥 {len(files)} new file(s) from git:")
                    for f in files[:10]:
                        print(f"  - {f}")
                    if len(files) > 10:
                        print(f"  ... and {len(files) - 10} more")
                else:
                    print("✅ No new markdown files from git")
            else:
                print("ℹ️  Could not determine new files (first run or shallow clone)")
                
        except subprocess.CalledProcessError as e:
            print(f"⚠️  Git sync failed: {e}")
        
        print()
    
    def check_inbox(self):
        """Check inbox folder for unprocessed items."""
        print("## Inbox Processing")
        
        inbox_dir = self.vault_dir / "inbox"
        if not inbox_dir.exists():
            print("⚠️  No inbox folder found\n")
            return
        
        self.inbox_items = [
            f for f in inbox_dir.glob("*.md")
            if f.name != ".gitkeep"
        ]
        
        if not self.inbox_items:
            print("✅ Inbox is clean (0 items)\n")
        else:
            print(f"📥 {len(self.inbox_items)} item(s) in inbox:")
            for item in self.inbox_items:
                print(f"  - {item.name}")
            print()
    
    def find_orphans(self):
        """Find notes with no incoming links."""
        print("## Orphan Check")
        
        # Load all notes
        self._load_notes()
        
        # Build set of all linked titles
        all_links: Set[str] = set()
        for note in self.notes:
            for link in note.wikilinks:
                # Handle [[Note]] and [[Note|alias]] formats
                link_target = link.split('|')[0].strip()
                all_links.add(link_target)
        
        # Check each folder for orphans
        folders = {
            'projects': self.vault_dir / "projects",
            'areas': self.vault_dir / "areas",
            'ideas': self.vault_dir / "ideas",
            'people': self.vault_dir / "people"
        }
        
        for folder_name, folder_path in folders.items():
            if not folder_path.exists():
                continue
                
            for file_path in folder_path.glob("*.md"):
                if file_path.name == ".gitkeep":
                    continue
                    
                title = file_path.stem
                if title not in all_links:
                    note = Note(file_path)
                    self.orphans[folder_name].append(note)
        
        total_orphans = sum(len(o) for o in self.orphans.values())
        
        if total_orphans == 0:
            print("✅ No orphans found\n")
        else:
            print(f"⚠️  {total_orphans} orphan(s) found:\n")
            
            for folder_name, orphan_list in self.orphans.items():
                if orphan_list:
                    print(f"{folder_name.title()}:")
                    for note in orphan_list[:10]:
                        print(f"  - {note.title}")
                    if len(orphan_list) > 10:
                        print(f"  ... and {len(orphan_list) - 10} more")
                    print()
    
    def find_stale_projects(self):
        """Find projects not modified in 30+ days."""
        print("## Stale Projects (30+ days without update)")
        
        threshold = datetime.now() - timedelta(days=STALE_DAYS)
        projects_dir = self.vault_dir / "projects"
        
        if not projects_dir.exists():
            print("⚠️  No projects folder found\n")
            return
        
        for file_path in projects_dir.glob("*.md"):
            if file_path.name == ".gitkeep":
                continue
                
            note = Note(file_path)
            if note.modified_date < threshold:
                self.stale_projects.append(note)
        
        # Sort by modification date (oldest first)
        self.stale_projects.sort(key=lambda n: n.modified_date)
        
        if not self.stale_projects:
            print("✅ No stale projects\n")
        else:
            print(f"⏰ {len(self.stale_projects)} stale project(s):\n")
            for note in self.stale_projects[:15]:
                date_str = note.modified_date.strftime("%Y-%m-%d")
                print(f"  - {note.title} (last: {date_str})")
            if len(self.stale_projects) > 15:
                print(f"  ... and {len(self.stale_projects) - 15} more")
            print()
    
    def validate_frontmatter(self):
        """Check frontmatter compliance on recent notes."""
        print("## Frontmatter Validation")
        
        issues = []
        threshold = datetime.now() - timedelta(days=7)
        
        # Check recently modified files
        for file_path in self.vault_dir.rglob("*.md"):
            if file_path.name == ".gitkeep":
                continue
                
            note = Note(file_path)
            if note.modified_date < threshold:
                continue
            
            # Check required fields
            if not note.frontmatter.get('type'):
                issues.append({
                    'file': file_path,
                    'issue': 'Missing type',
                    'note': note
                })
            
            if not note.frontmatter.get('summary'):
                issues.append({
                    'file': file_path,
                    'issue': 'Missing summary',
                    'note': note
                })
            
            # Check status for actionable types
            note_type = note.frontmatter.get('type', '')
            if note_type in ('project', 'idea') and not note.frontmatter.get('status'):
                issues.append({
                    'file': file_path,
                    'issue': 'Missing status',
                    'note': note
                })
        
        self.frontmatter_issues = issues
        
        if not issues:
            print("✅ Recent notes have proper frontmatter\n")
        else:
            print(f"⚠️  {len(issues)} frontmatter issue(s):\n")
            
            # Group by issue type
            by_type: Dict[str, List] = {}
            for issue in issues:
                issue_type = issue['issue']
                if issue_type not in by_type:
                    by_type[issue_type] = []
                by_type[issue_type].append(issue)
            
            for issue_type, issue_list in by_type.items():
                print(f"{issue_type}: {len(issue_list)} note(s)")
            print()
    
    def check_projects_board(self):
        """Check if Projects Board is in sync with active projects."""
        print("## Projects Board Sync Check")
        
        board_path = self.vault_dir / "Projects Board.md"
        if not board_path.exists():
            print("⚠️  No Projects Board found\n")
            return
        
        board_content = board_path.read_text(encoding='utf-8')
        
        # Extract project links from board
        board_projects = set(re.findall(r'\[\[([^\]]+)\]\]', board_content))
        
        # Get active projects from projects folder
        active_projects: Set[str] = set()
        projects_dir = self.vault_dir / "projects"
        
        for file_path in projects_dir.glob("*.md"):
            if file_path.name == ".gitkeep":
                continue
            note = Note(file_path)
            if note.frontmatter.get('status') == 'active':
                active_projects.add(file_path.stem)
        
        # Find discrepancies
        not_on_board = active_projects - board_projects
        on_board_not_active = board_projects - active_projects
        
        if not not_on_board and not on_board_not_active:
            print("✅ Projects Board is in sync\n")
        else:
            if not_on_board:
                print(f"⚠️  {len(not_on_board)} active project(s) not on board:")
                for p in sorted(not_on_board)[:10]:
                    print(f"  - {p}")
                if len(not_on_board) > 10:
                    print(f"  ... and {len(not_on_board) - 10} more")
                print()
            
            if on_board_not_active:
                print(f"ℹ️  {len(on_board_not_active)} board item(s) may be stale:")
                for p in sorted(on_board_not_active)[:5]:
                    print(f"  - {p}")
                print()
    
    def _load_notes(self):
        """Load all notes from the vault."""
        for file_path in self.vault_dir.rglob("*.md"):
            if file_path.name == ".gitkeep":
                continue
            try:
                note = Note(file_path)
                self.notes.append(note)
            except Exception as e:
                print(f"  Warning: Could not load {file_path}: {e}")
    
    def generate_report(self) -> Dict:
        """Generate a structured report of findings."""
        print("## Summary")
        print(f"- Inbox items: {len(self.inbox_items)}")
        print(f"- Orphan notes: {sum(len(o) for o in self.orphans.values())}")
        print(f"- Stale projects: {len(self.stale_projects)}")
        print(f"- Frontmatter issues: {len(self.frontmatter_issues)}")
        print(f"- New git files: {len(self.new_git_files)}")
        print()
        print("🌿 Gardening complete!")
        
        return {
            'inbox_count': len(self.inbox_items),
            'orphans': self.orphans,
            'stale_projects': self.stale_projects,
            'frontmatter_issues': self.frontmatter_issues,
            'new_git_files': self.new_git_files
        }


def main():
    """Main entry point."""
    garden = VaultGarden()
    results = garden.run()
    return results


if __name__ == "__main__":
    main()
