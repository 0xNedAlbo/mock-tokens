// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    uint8 private decimals_;

    constructor(string memory name, string memory symbol, uint8 tokenDecimals) ERC20(name, symbol) {
        require(tokenDecimals > 0, "MockERC20: decimals can't be zero");
        decimals_ = tokenDecimals;
    }

    function decimals() public view virtual override returns (uint8) {
        return decimals_;
    }

    function mint(address to, uint256 amount) public virtual {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public virtual {
        _burn(from, amount);
    }
}
