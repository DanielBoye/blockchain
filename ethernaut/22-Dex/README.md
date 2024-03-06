# Dex


Division in:

```solidity
return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
```
is unsafe and we can swap and swap and swap until we have enough tokens to complete the challenge
