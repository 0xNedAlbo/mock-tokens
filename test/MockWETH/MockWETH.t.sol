// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "../Base.t.sol";

import "@src/MockWETH.sol";

contract MockWETHTest is BaseTest {
    MockWETH weth;

    function setUp() public override {
        super.setUp();
        weth = new MockWETH();
    }

    modifier whenUserHasWETH(address user, uint256 amount) {
        weth.mint(user, amount);
        _;
    }

    modifier whenUserHasETH(address user, uint256 amount) {
        deal(user, amount);
        _;
    }

    modifier whenUserHasDepositedETH(address user, uint256 wad) {
        deal(user, wad);
        vm.prank(user);
        weth.deposit{value: wad}();
        _;
    }
}
