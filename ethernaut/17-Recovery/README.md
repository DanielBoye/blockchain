# Recovery

---
Objective:
- This level will be completed if you can recover (or remove) the 0.001 ether from the lost contract address.
---

Notes:

Highligh `payable` to see where eth is sent
In `receive()` and `destroy`-
`receive()` is when the contract gets eth, and it will update the balance accordingly

`destroy` will `selfdestruct` the contract so it will delete itself and send all of the remaing tokens to the `_to` address
```solidity
function destroy(address payable _to) public {
    selfdestruct(_to);
}
```

The challenge will be to find the address
So a quick google search found [this](https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed) explenation on the Ethereum Stack Exchange

So we can use 
```solidity
nonce0= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x80))))));
nonce1= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x01))))));
```
to generate/find the address just from the challenge address!

Making a new contract that will do this
```solidity
address addr = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), sender, bytes1(0x01))))));
       return addr;
```

I got `0xd58c9EA75946Dd0C1eDBc59446c72A7099A5e169`

So then call `destroy` 