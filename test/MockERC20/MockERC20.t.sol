// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "../Base.t.sol";

contract MockERC20Test is BaseTest {
    modifier whenUserHasDai(address user, uint256 amount) {
        deal(address(tokens.dai), user, amount, true);
        _;
    }
}
