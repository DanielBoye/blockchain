# Privacy

---
Objective: 
- Unlock this contract to beat the level.
---

Notes:

Set locked to false
Call `unlock`

Has one condition to be met
Our `_key` need to be `== bytes16(data[2])`

State variables is stored in slots
Each slot holds up to 32 bytes.


```solidity
// slot 0
bool public locked = true;

// uint256 takes up 32 bytes, so it gets it's own slot
// slot 1
uint256 public ID = block.timestamp;

// uint8 takes up 1 byte
// slot 2
uint8 private flattening = 10;

// uint 8 takes up 1 byte
// so it is in the same slot since it is not filled
// slot 2
uint8 private denomination = 255;

// uint16 take up 2 bytes
// we have used up 2 bytes, so this still fits inside
// 2+2 = 8 != 32
// slot 2
uint16 private awkwardness = uint16(block.timestamp);

// fixed sized arrays use THE SLOT THAT IS AVAILABLE NEXT 
// since it is 3 elements, the next one will also use 32 bytes
// it will have 3 slots
// slot 3, slot 4, slot 5
bytes32[3] private data;
```

1. Get what is at the `data[2]` for the key
```python 
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

storage_position = 5

storage_data = w3.eth.get_storage_at(contract_address, storage_position)
```

2. Shorten it to 16 bytes
```python
print(storage_data.hex()[:34])
```

3. Send the key in the unlock function
Send the output to remix