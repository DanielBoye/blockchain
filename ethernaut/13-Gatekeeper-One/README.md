# Gatekeeper One

---
Objective: 
- Make it past the gatekeeper and register as an entrant to pass this level.
---

Notes:

Need to call `enter`
This will set entrant to `true`

`enter` has three modifiers
1. Do the same as in 04-Telephone. Use a smart contract as a proxy
2. Make that the modulus of 8191 with gas left should be 0
3. Switch bettween multiple datatypes. Bitshift 1 to the 64'th place, so it gets cut out for the 2 in `gateThree`