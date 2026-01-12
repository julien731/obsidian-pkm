---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2023-07-04
tags:
  - important
---

# Braive Bug Reports

- No link on the logo
    
    Although maybe not a bug per se, it’s a pretty common setup to have a link to the homepage on the logo. Without it, there is no other way than to edit the URL to go back to the home page.
    
    ![Untitled](Braive%20Bug%20Reports/Untitled.png)
    
- Cookie consent banner hiding behind the footer
    
    ## Steps to Reproduce
    
    1. Open [https://braive.com/en/about/braive](https://braive.com/en/about/braive) without ever having accepted the cookies consent (or open incognito mode).
    2. Scroll down to the bottom of the page.
    
    ## Expected
    
    The cookie consent banner should always display.
    
    ## Actual
    
    The cookie consent banner hides behind the footer.
    
    [Screen Recording 2023-07-04 at 17.46.25.mov](Braive%20Bug%20Reports/Screen_Recording_2023-07-04_at_17.46.25.mov)
    
- Cookie consent banner conflict with Ghostery ad-blocker
    
    ## Prerequisite
    
    Have the Ghostery ad-blocker addon installed on Chrome.
    
    ## Steps to Reproduce
    
    1. Open braive.com
    
    ## Expected
    
    The cookie consent banner should show up normally, letting users accept.
    
    ## Actual
    
    The cookie consent popup is empty.
    
    Pausing Ghostery resolves the problem.
    
    ![Untitled](Braive%20Bug%20Reports/Untitled%201.png)
    
- No practical call-to-action after MHC
    
    ## Steps to Reproduce
    
    1. Take the mental health check
    
    ## Expected
    
    There should be a strong call-to action for patients to take the next step they need to take.
    
    ## Actual
    
    <aside>
    💡 The CTAs might be different depending on the MHC results. I am making an assumption here given that it seems to match what my friend told me about his MHC experience.
    
    </aside>
    
    The only CTA is for retaking the MHC.
    
    ![Untitled](Braive%20Bug%20Reports/Untitled%202.png)
    
    In addition, once logged in (which is automatic after the MHC) there is no way to see the list of treatment programs. The user would have to either have the direct link, or:
    
    1. Log out
    2. Find a program
    3. Click enroll
    4. Log back in
    5. Click enroll again
    
    ![Untitled](Braive%20Bug%20Reports/Untitled%203.png)
    
- No payment options
    
    ## Steps to Reproduce
    
    <aside>
    💡 I encountered this after taking the MHC. There could be other flows where the outcome is different.
    
    </aside>
    
    1. Take the MHC
    2. Log out
    3. Find a program to enroll into
    4. Click enroll
        1. Log in
        2. Click enroll again
    
    ## Expected
    
    Patients should be able to pay for the program and complete their enrollment.
    
    ## Actual
    
    There are no payment options available.
    
    I tried using a VPN set to Sweden and Norway to confirm whether it is a geographical restriction but it doesn’t seem to be the case.
    
    ![Untitled](Braive%20Bug%20Reports/Untitled%204.png)
    
    ## Note
    
    There are a few errors showing up in the console which could be potential sources for this problem.
    
    ![Untitled](Braive%20Bug%20Reports/Untitled%205.png)