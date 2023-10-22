# Naught Coin

---
Objective:
- Complete this level by getting your token balance to 0.
---

Notes:

We get some token
Bypass timelock

We mint in the `constructor`

In the `transfer()` function it uses `transfer` to send the tokens. 

We can use `transferFrom` inside another contract to do this
Since we can approve the contract to send our tokens

We first need to deploy our hack contract
Then approve the hack contract to deal with our tokens
Then call the hack contract to transfer the tokens to the hack contract balance. 