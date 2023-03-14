// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockWETH.t.sol";

contract WithdrawTest is MockWETHTest {
    function test_whenUserHasDepositedETH_withdraw_returnsETH() public whenUserHasDepositedETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        weth.withdraw(100 ether);
        assertEq(users.alice.balance, 100 ether);
        assertEq(address(weth).balance, 0 ether);
    }

    function test_whenUserHasDepositedETH_withdraw_decreasesBalance()
        public
        whenUserHasDepositedETH(users.alice, 100 ether)
    {
        vm.prank(users.alice);
        weth.withdraw(100 ether);
        assertEq(weth.balanceOf(users.alice), 0 ether);
    }

    function test_whenUserHasDepositedETH_withdraw_decreasesTotalSupply()
        public
        whenUserHasDepositedETH(users.alice, 100 ether)
    {
        vm.prank(users.alice);
        weth.withdraw(100 ether);
        assertEq(weth.totalSupply(), 0 ether);
    }

    function test_whenUserHasDepositedETH_withdraw_totalMintedIsUnchanged()
        public
        whenUserHasDepositedETH(users.alice, 100 ether)
    {
        vm.prank(users.bob);
        weth.mint(users.bob, 200 ether);
        vm.prank(users.alice);
        weth.withdraw(100 ether);
        assertEq(weth.totalMinted(), 200 ether);
    }
}
