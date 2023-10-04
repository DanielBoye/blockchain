# Fallback

--- 
Objective: 
- you claim ownership of the contract
- you reduce its balance to 0
---

## 1. Check how `owner` is set
So first off I want to look at how the `owner` is set, and if there is any way for me to set it to myself. 


`owner = msg.sender;` is present three times. First in the `constructor()`
```solidity
constructor() {
    owner = msg.sender;
    contributions[msg.sender] = 1000 * (1 ether);
  }
```
Then in the `contribute()`
```solidity
function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
}
```
And at last in the `recive()`
```solidity
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
```

## 2. What conditions needs to be met for editing `owner`

When looking more close on the `contribute()` function, we can see that the conditions that needs to be met is inside of the `require` and `if` condition

Here we can note down that the `msg.value` needs to be lesser than 0.001 ether
```solidity
require(msg.value < 0.001 ether);
```
The `if` condition is true if the `contributions` of the `msg.sender` is **greater** than the `contributions` of the `owner`. 
```solidity
if(contributions[msg.sender] > contributions[owner])
```

`contributions[msg.sender]` was definded in the `constructor()` to 1000 eth
```solidity
constructor() {
    owner = msg.sender;
    contributions[msg.sender] = 1000 * (1 ether);
}
```

So if we send less than a 0.001 ether, our transaction should go through

## 3. Claming ownership


