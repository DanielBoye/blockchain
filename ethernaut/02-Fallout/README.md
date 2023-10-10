# Fallout

--- 
Objective: 
- Claim ownership of the contract below to complete this level.
---

## 1. Check how `owner` is set
To claim ownership of the contract, we need to pay attention to the constructor function and the compiler version. In Solidity 0.6.0, the constructor function has to be the same name as the contract itself and is executed only once when the contract is deployed. 

However, in the challenge, there is a typing error in the constructor function's name. It is currently defined as `Fal1out()` instead of `Fallout()`.

```solidity
function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
}
```

This leaves the function vulnerable since it is `public` so anyone can call it. 

## 2. Claming ownership

To claim ownership, we just need to call the function `Fal1out()`. To do this we need to connect to it via a smart contract

## 3. Completing the Challenge

Once we have executed the corrected function, we have successfully claimed ownership of the "Fallout" contract. Additionally, this action does not require any complex conditions to be met, making it a straightforward solution to complete the challenge.

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

In the `Deployed Contracts` the `FalloutSolve.sol` contract should be connected to the smart contract and you should see something like this. 

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/b9b19206-5921-48d6-bc7a-7508e62844c8" width="300">

## Calling the functions

To connect to connect and solving the challenge, I've made a smart contract that will make us check the `owner` state and calling `Fal1out()`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

interface solve {
    function owner() external view returns (address);
    function Fal1out() external payable;
}
```

### 1. Check `owner` before

First I am calling the `owner` just to check that I am not set to the owner 

### 2. Call `Fal1out()`

Call `Fal1out()` with 1 wei

### 3. Check that `owner` is set to us

Oh yeah 😎

## Submitting the instance

Now go back to ethernaut and click **Submit Instance**

And confirm the transaction with Metamask

<img src="https://github.com/DanielBoye/blockchain/assets/83395536/edf765af-292a-459e-88e6-8041162b1b75" width="500">

Let's go to the next one
