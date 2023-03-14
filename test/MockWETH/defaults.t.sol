// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./MockWETH.t.sol";

contract DefaultsTest is MockWETHTest {
    function test_name_returnsWrappedEther() public {
        assertEq(weth.name(), "Wrapped Ether");
    }

    function test_symbol_returnsWETH() public {
        assertEq(weth.symbol(), "WETH");
    }

    function test_decimals_returns18() public {
        assertEq(weth.decimals(), 18);
    }

    function test_totalSupply_returns0() public {
        assertEq(weth.totalSupply(), 0);
    }

    function test_addressBalance_returns0() public {
        assertEq(address(weth).balance, 0);
    }
}
