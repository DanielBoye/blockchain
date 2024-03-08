# Denial

---
Objective:
- This is a simple wallet that drips funds over time. You can withdraw the funds slowly by becoming a withdrawing partner.
---

If you can deny the owner from withdrawing funds when they call withdraw() (whilst the contract still has funds, and the transaction is of 1M gas or less) you will win this level.

We need to deny that the owner can not withdraw the funds when they call `withdraw()`

To make the owner deny the withdraw of funds we can drain the contract of gas. For that wee need to be a partner. To achieve this we call `setWithdrawPartner` with our address `address(this)`. From there the vulnerabilty lies in the low level `call` in 

```solidity
partner.call{value:amountToSend}("");
```
That operation will be true or false. It does not check the return value that is sending back by our smart contract.

So it does not check the return value, and we can make a loop to consume all forwarding gas. Then it will soon revert since it is out of gas. Then the owner will not be able to withdraw anything

The `call` will send the empty `msg.data`. That means that our fallback will be called and we can return that it `invalid()`

Therefore our exploit is now:

```solidity
constructor(Denial target) {
        target.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        assembly {
            invalid()
        }
    }
```