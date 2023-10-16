# Telephone

---
Objective:
- Claim ownership of the contract below to complete this level.
---

## 1. Check how `owner` is set
To claim ownership of the contract, we need to be set to the `owner`. This is done within the `constructur()`, but there the `msg.sender` is set to the owner. This will only set the `owner` as the person who launched the smart contract so it is not vulnerable

However, in the function `changeOwner()` we can pass through an adress as `_owner` and be set as `owner = _owner;` **ONLY** if 

```solidity
if (tx.origin != msg.sender)
```

Lets dive into how to set the `msg.sender` to something else...

## 2. Edit the `msg.sender`
This can be done with using a smart contract as a proxy. Since we can interact with our created contract, that can then interact to the challenge contract

```
Me          -> Hack contract    -> Challenge contract
tx.orgin    -> tx.orgin = me    -> tx.orgin = me
            -> msg.sender me    -> msg.sender = Hack contract
```

## 3. Solution in Solidity
To do this we can utilize the `changeOwner(msg.sender)` inside of the constructor in our hack contract. The full hack contract code will look something like this

```solidity
contract Hack {
    constructor(address _target) {
        Telephone(_target).changeOwner(msg.sender);
    }
}
```

# My solution in Remix