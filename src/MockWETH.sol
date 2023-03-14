// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "forge-std/Test.sol";
import "@src/MockERC20.sol";

contract MockWETH is MockERC20, Test {
    event Deposit(address indexed dst, uint wad);
    event Withdrawal(address indexed src, uint wad);

    uint256 public totalMinted;

    constructor() MockERC20("Wrapped Ether", "WETH", 18) {}

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint wad) public {
        _burn(msg.sender, wad);
        payable(msg.sender).transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    function mint(address account, uint256 amount) public virtual override {
        totalMinted += amount;
        super.mint(account, amount);
    }

    function burn(address account, uint256 amount) public virtual override {
        super.burn(account, amount);
        require(amount <= totalMinted, "MockWETH: burn amount exceeds total minted amount");
        totalMinted -= amount;
    }
}
