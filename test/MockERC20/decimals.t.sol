// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockERC20.t.sol";

contract DecimalsTest is MockERC20Test {
    function test_whenDecimalsIsNotZero_constructorSetsDecimals() public {
        assertEq(tokens.dai.decimals(), 18);
        assertEq(tokens.usdc.decimals(), 6);
    }

    function test_whenDecimalsIsZero_constructorReverts() public {
        vm.expectRevert("MockERC20: decimals can't be zero");
        new MockERC20("Dai Stablecoin", "DAI", 0);
    }
}
