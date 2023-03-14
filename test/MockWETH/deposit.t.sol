// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockWETH.t.sol";

contract DepositTest is MockWETHTest {
    function test_whenUserHasETH_deposit_mintsWETH() public whenUserHasETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        weth.deposit{value: 100 ether}();
        assertEq(weth.balanceOf(users.alice), 100 ether);
    }

    function test_whenUserHasETH_deposit_sendsETH() public whenUserHasETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        weth.deposit{value: 100 ether}();
        assertEq(weth.balanceOf(users.alice), 100 ether);
        assertEq(address(weth).balance, 100 ether);
    }

    function test_whenUserHasETH_deposit_doesNotIncreaseTotalMinted() public whenUserHasETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        weth.deposit{value: 100 ether}();
        assertEq(weth.totalMinted(), 0);
    }

    event Deposit(address indexed dst, uint wad);

    function test_whenUserHasETH_deposit_emitsDepositEvent() public whenUserHasETH(users.alice, 100 ether) {
        vm.prank(users.alice);
        vm.expectEmit();
        emit Deposit(users.alice, 100 ether);
        weth.deposit{value: 100 ether}();
    }
}
