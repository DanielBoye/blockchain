# Token

---
Objective:
- You are given 20 tokens to start with and you will beat the level if you somehow manage to get your hands on any additional tokens. Preferably a very large amount of tokens.
---

notes:

`balance` is set in constructor

only place to edit `balance` is in `transfer`

in solidity 0.6.0!!!
safemath not invented
overflows and underflows

this will underflow and go to max uint

send 1 to msg.sender