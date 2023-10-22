# Gatekeeper Two

---
Objective: 
- Register as an entrant to pass this level.
---

Notes:

`gateOne` is the same for Telephone
Need to call everything from a smart contract

`gateTwo` checks that the `extcodesize` from us is 0
This means all of the code that we send
But the constructor is not in the calculation
So if we do everything from inside of the `constructor`, we bypass this

`gateThree` is math with XOR. Explenation in the code below
```solidty
// max = 1111111111

// Since we know 
// a ^ a ^ b = b

// Then 
// s ^ s ^ key = s ^ max
uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
uint64 k = s ^ type(uint64).max;


bytes8 key = bytes8(k);
```