# Insomni'hack Teaser 2024

I tried to play the Insomni'hack Teaser event with the hope of some blockchain challenge and there was one! So let's solve it.

## Unamed-web3

### Challenge description

```
Introducing UnnamedWeb3 - now fortified with Smart Contract technology and Blockchain for robust, decentralized DNS security.
```

### Solution

The server had the ability to generate required signatures by exploiting a truncation in the domain part to 32 bytes in the `verify` function.

```solidity
assembly {
    tmp := mload(add(part, 32))
}
```
Steps: 

1. Register domain with null bytes
2. Acquiring transfer codes
3. Reconstructing them for flag domain. 

The first step is to register the domain with the vulnerability in the `tmp` variable. Since the variable `tmp` was created form the string using the inline assembly, we can exploit this with registering a specific domain with the necessary null bytes in its part.

The second step is to get the transfer codes. This can be done with firstly calling the `initiateTransfer` function in the smart contract, that will as it says, initiate the transfer, then calling the webserver at `/transfer-codes` if you own the domain. It will return you the codes. then acquiring the transfer codes.

Third step is to reassemble the code. In the `verify`, the code is concatenated to a 65 byte signature, one for each part of the domain. 

```solidity
for (uint i = 0; i < partCount; i++) {
    bytes32 r;
    bytes32 s;
    uint8 v = uint8(signature[i * 65 + 64]);
    assembly {
        r := mload(add(signature, add(32, mul(i, 65))))
        s := mload(add(signature, add(64, mul(i, 65))))
}
```

So we need to extract the 65-byte part for each part of the domain. Then from the transfer codes we got, we can concatenate them together and make a transfer code that will fit with the flag domain.

The last step is to get the flag with sending a POST request to `/send-flag`