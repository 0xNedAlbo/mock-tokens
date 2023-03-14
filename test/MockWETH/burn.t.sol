// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockWETH.t.sol";

contract BurnTest is MockWETHTest {
    function test_burn_removesTokensFromReceiver() public whenUserHasWETH(users.alice, 100 ether) {
        vm.prank(users.bob);
        weth.burn(users.alice, 30 ether);
        assertEq(weth.balanceOf(users.alice), 70 ether);
        vm.prank(users.alice);
        weth.burn(users.alice, 70 ether);
        assertEq(weth.balanceOf(users.alice), 0);
    }

    function test_burn_decreasesTotalSupply()
        public
        whenUserHasWETH(users.alice, 100 ether)
        whenUserHasWETH(users.bob, 20 ether)
    {
        vm.prank(users.alice);
        weth.burn(users.alice, 10 ether);
        assertEq(weth.totalSupply(), 110 ether);
    }

    function test_burn_whenAmountIsGreaterThanBalance_reverts() public whenUserHasWETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        vm.expectRevert("ERC20: burn amount exceeds balance");
        weth.burn(users.alice, 100 ether + 1);
    }

    function test_burn_decreases_totalMinted() public whenUserHasWETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        weth.burn(users.alice, 10 ether);
        assertEq(weth.totalMinted(), 90 ether);
    }
}
