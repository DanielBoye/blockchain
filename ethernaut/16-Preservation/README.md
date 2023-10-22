# Preservation

---
Objective:
- The goal of this level is for you to claim ownership of the instance you are given.
---

Notes:

`owner` is set in the constructor, so we can not edit it (theoretically)

we can use `setFirstTime` do delegatecall into our contract with using `setTime`

From there we can use the same storage, and itterate through so we can set ourselves `msg.sender` as the owner