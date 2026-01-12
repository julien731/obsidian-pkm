---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-11-06
---

# Okya Orders Creation Error

```mermaid
sequenceDiagram
	participant M as Middleware
  participant O as Okya
  
  M->>O: Send order
  
  alt Update Order Transaction
	  O->>O: Update order data
	  Note over O: ✅
	  O->>O: Create background job for order.updated event
	  Note over O: ❌
	  O-->>M: Return error response
  end
```

# Explanation

The menu sync is a heavy, atomic process. Since it can update product prices, we must ensure that no pending orders are submitted with outdated prices.

To maintain data consistency, we apply a short database lock during the sync. It ensures that the update will go through and that no other transaction is processed at the same time.

There is another step after that, which is streaming the event to Kafka. There is no lock on this process, and the system got overloaded by the huge amount of menu sync that was done outside of agreed-upon hours. This failed, leading to a failed response from the API.