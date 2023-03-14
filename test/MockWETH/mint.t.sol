// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockWETH.t.sol";

contract MintTest is MockWETHTest {
    function test_mint_increasesTokenBalanceOfReceiver() public {
        weth.mint(users.alice, 100 ether);
        assertEq(weth.balanceOf(users.alice), 100 ether);
    }

    function test_mint_increasesTotalSupply() public {
        weth.mint(users.alice, 100 ether);
        assertEq(weth.totalSupply(), 100 ether);
    }

    function test_mint_increasesTotalMinted() public {
        weth.mint(users.alice, 100 ether);
        assertEq(weth.totalMinted(), 100 ether);
    }

    function test_mint_EthBalanceOfReceiverIsUnchanged() public {
        weth.mint(users.alice, 100 ether);
        assertEq(users.alice.balance, 0);
    }
}
