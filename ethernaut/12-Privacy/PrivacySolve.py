from web3 import Web3

node = ""

contract_address = "0x37979c9C65b89b0166D8cc534B590504d9285622"

w3 = Web3(Web3.HTTPProvider(node))

contract_abi = [
    {
        "inputs": [
            {
                "internalType": "bytes32[3]",
                "name": "_data",
                "type": "bytes32[3]"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [],
        "name": "ID",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "locked",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "bytes16",
                "name": "_key",
                "type": "bytes16"
            }
        ],
        "name": "unlock",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
]

contract = w3.eth.contract(address=contract_address, abi=contract_abi)

storage_position = 5

storage_data = w3.eth.get_storage_at(contract_address, storage_position)

print(storage_data.hex()[:34])
