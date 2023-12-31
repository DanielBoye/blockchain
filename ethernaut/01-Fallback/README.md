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

When looking more closely on the `contribute()` function, we can see that the conditions that need to be met are inside of the `require` and `if` condition

Here we can note down that the `msg.value` needs to be less than 0.001 ether
```solidity
require(msg.value < 0.001 ether);
```
The `if` condition is true if the `contributions` of the `msg.sender` is **greater** than the `contributions` of the `owner`. 
```solidity
if(contributions[msg.sender] > contributions[owner])
```

`contributions[msg.sender]` was defined in the `constructor()` to 1000 eth
```solidity
constructor() {
    owner = msg.sender;
    contributions[msg.sender] = 1000 * (1 ether);
}
```

So if we send less than a 0.001 ether, our transaction should go through

## 3. Claming ownership

To claim ownership of the contract we need to send less than 1000 eth but more than 0.001 eth to the `contribute()` function to contribute some eth. 

From there the `contributions[msg.sender] += msg.value;` is set, so we can then call the `receive()` with sendings some wei to finally be able to set ourselves to `owner = msg.sender;`!

## 4. Withdraw the money

To withdraw the money, we call `withdraw()`

# My solution in Remix

## Setup

*this step goes for all setups on Remix, and does not match every challenge*

First off we need to get the contract address from ethernaut. We do this with the `contract.address`

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/adb53f3a-7bda-40ee-bb22-ed6a9008f2b4" width="400">

Now copy the contract code and compile it in Remix.

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/9fa1baf8-483d-4e44-a1e8-44a3105c62a6" width="300">

### Connect to the smart contract

Make sure your environment is set to `Injected Provider - Metamask` with your Sepholia wallet

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/866fb436-3f98-4238-8834-1d53cd9d6245" width="400">

Now deploy it at the address of the `contract.address` that you got from ethernaut

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/89593273-87df-407f-aab8-b139d45a8098" width="450">

In the `Deployed Contracts` the `Fallback` contract should be connected to the smart contract and you should see something like this. 

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/b9b19206-5921-48d6-bc7a-7508e62844c8" width="300">

## Calling the functions

We now know *what* functions to call, and in which *order* too

1. `contribute()` with 1 wei **transact (payable)**
2. `receive()` with 1 wei **transact (payable)** 
3. `owner` **call** 
4. `withdraw` **transact (not payable)**


###  1. `contribute()`

First I am calling the `owner` just to check that I am not set to the owner 

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/aeb384d7-d110-41b3-8301-8d485dd94782" width="300">

Perfect. Now lets call `contribute()` with 1 wei.

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/0e826139-b861-4368-a8df-27f85bf6e295" width="300">

Click the red contribute button 

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/de069fe0-ff5b-4109-bc36-f73efa11911c" width="300">

And confirm the transaction with Metamask

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/fc75422d-d3d3-4088-bed9-56b11d5ed8b3" width="200">

### 2. `receive()`

To call the `receive()` function inside of Remix we need to call it as a [**Low level interactions**](https://docs.soliditylang.org/en/v0.6.2/contracts.html#receive-ether-function)

Lets send 1 wei

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/0e826139-b861-4368-a8df-27f85bf6e295" width="300">

And click the yellow transparent Transact button

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/427febf5-2dde-4cd2-9029-f1185cc5d65c" width="250">

And confirm the transaction in Metamask


### 3. `owner`

Lets check if we are set to the `owner` now

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/0f6f24d5-b445-4ecb-b013-4b04f4cb6c7b" width="300">

Oh yeah 😎

Let's withdraw the money now

### 4. `withdraw()`

Call `withdraw()`

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/12590bd4-676a-4932-9b36-8e3434efbad5" width="100">

And check if the contract balance is 0.

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/e9a24ec9-7710-475b-98d4-df4b28c01a28" width="100">

Boom!

## Submitting the instance

Now go back to ethernaut and click **Submit Instance**

And confirm the transaction with Metamask

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/edf765af-292a-459e-88e6-8041162b1b75" width="500">

Let's go to the next one
