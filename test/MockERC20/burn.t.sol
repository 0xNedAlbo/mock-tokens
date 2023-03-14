// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockERC20.t.sol";

contract BurnTest is MockERC20Test {
    function test_burn_removesTokensFromReceiver() public whenUserHasDai(users.alice, 100 ether) {
        vm.prank(users.bob);
        tokens.dai.burn(users.alice, 30 ether);
        assertEq(tokens.dai.balanceOf(users.alice), 70 ether);
        vm.prank(users.alice);
        tokens.dai.burn(users.alice, 70 ether);
        assertEq(tokens.dai.balanceOf(users.alice), 0);
    }

    function test_burn_decreasesTotalSupply()
        public
        whenUserHasDai(users.alice, 100 ether)
        whenUserHasDai(users.bob, 20 ether)
    {
        vm.prank(users.alice);
        tokens.dai.burn(users.alice, 10 ether);
        assertEq(tokens.dai.totalSupply(), 110 ether);
    }

    function test_burn_whenAmountIsGreaterThanBalance_reverts() public whenUserHasDai(users.alice, 100 ether) {
        vm.prank(users.alice);
        vm.expectRevert("ERC20: burn amount exceeds balance");
        tokens.dai.burn(users.alice, 100 ether + 1);
    }
}
