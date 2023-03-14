// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockERC20.t.sol";

contract MintTest is MockERC20Test {
    function test_mint_transfersTokensToReceiver() public {
        vm.prank(users.bob);
        tokens.dai.mint(users.alice, 100 ether);
        assertEq(tokens.dai.balanceOf(users.alice), 100 ether);
        assertEq(tokens.dai.balanceOf(users.bob), 0);
    }

    function test_mint_increasesTotalSupply() public {
        vm.prank(users.alice);
        tokens.dai.mint(users.bob, 100 ether);
        tokens.dai.mint(users.alice, 200 ether);
        assertEq(tokens.dai.totalSupply(), 300 ether);
    }
}
