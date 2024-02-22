// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solve {
  constructor(MagicNum target) {
    bytes memory payload = hex"69602a60005260206000f3600052600a6016f3";    address addr;

    assembly {
      addr := create(0, add(payload, 0x20), 0x13)
    }

    require(addr != address(0));
    target.setSolver(addr);

  }
  
}


contract MagicNum {

  address public solver;

  constructor() {}

  function setSolver(address _solver) public {
    solver = _solver;
  }

  /*
    ____________/\\\_______/\\\\\\\\\_____        
     __________/\\\\\_____/\\\///////\\\___       
      ________/\\\/\\\____\///______\//\\\__      
       ______/\\\/\/\\\______________/\\\/___     
        ____/\\\/__\/\\\___________/\\\//_____    
         __/\\\\\\\\\\\\\\\\_____/\\\//________   
          _\///////////\\\//____/\\\/___________  
           ___________\/\\\_____/\\\\\\\\\\\\\\\_ 
            ___________\///_____\///////////////__
  */
}