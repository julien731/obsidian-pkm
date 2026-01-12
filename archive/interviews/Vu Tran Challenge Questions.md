---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2024-09-09
tags:
  - interview
---

# Vu Tran Challenge Questions

- Order status management: what happens if no driver can be found/assigned after the food was cooked?
    
    ![image.png](Vu%20Tran%20Challenge%20Questions/image.png)
    
    - If the driver only starts going to the restaurant when the food is ready, customers will always get their food cold and slow.
- For the ETA updates, which system would handle the “significant change” calculation?
    
    ![image.png](Vu%20Tran%20Challenge%20Questions/image%201.png)
    
    - The customer can potentially receive a lot of notifications. Won’t that be annoying?
- Have you weighted the benefits or having to implement a real-time database and websockets for the live order status update?
- Error handling diagram: it’s nice to think about it, but it’s not practical in isolation from the features.
- “As a user, I can receive push notifications for significant status changes” → this is not factored in when outlining the risks with GPS location accuracy

![image.png](Vu%20Tran%20Challenge%20Questions/image%202.png)

- Does the “driver at restaurant” status really matter? Related to question 1.

![image.png](Vu%20Tran%20Challenge%20Questions/image%203.png)