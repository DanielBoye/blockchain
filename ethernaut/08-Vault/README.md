# Vault

---
Objective:
Unlock the vault to pass the level!
---

notes:

make `locked` to `false`
only place to do that is inside of the `unlock()`
`password == _password`

the `_password` *is* private byt
all state variables can be accessed via `web3`

```javascript
await web3.eth.getStorageAt(contract.address, 1)
```
