# Force

---
Objective:
The goal of this level is to make the balance of the contract greater than zero.
---

notes: 

send eth to it
self destruct

make a contract with a constructor
(adress payable target) payable {
    selfdestruct(target)
}

since it will send eth to the contract, and then into the `Force`