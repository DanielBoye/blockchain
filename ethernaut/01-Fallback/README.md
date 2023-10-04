# Fallback

--- 
Objective: 
- you claim ownership of the contract
- you reduce its balance to 0
---

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


