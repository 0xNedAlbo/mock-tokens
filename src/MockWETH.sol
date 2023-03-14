// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "forge-std/Test.sol";
import "@src/MockERC20.sol";
import "@src/interfaces/IWETH.sol";

/// @notice This is a mock WETH token designed for testing purposes only.
/// Minting and burning is permissionless, which means that anyone can
/// mint and burn any amount of tokens for any account. Please note that
/// this contract is not intended for production use and should only be
/// used in test environments unless you want money printer go brrrr.
contract MockWETH is MockERC20, IWETH {
    event Deposit(address indexed dst, uint wad);
    event Withdrawal(address indexed src, uint wad);

    /// @notice The total amount of WETH that has been minted. Does not count deposits.
    uint256 public totalMinted;

    /// @notice Creates a new mock WETH token.
    constructor() MockERC20("Wrapped Ether", "WETH", 18) {}

    receive() external payable {
        deposit();
    }

    /// @notice Mints new tokens for the given account if ETH is sent with the transaction.
    /// Increases totalSupply but not totalMinted.
    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Burns tokens from the given account and sends ETH to the account.
    /// Reduces totalSupply but not totalMinted.
    /// @param wad The amount of WETH to withdraw.
    function withdraw(uint wad) public {
        _burn(msg.sender, wad);
        payable(msg.sender).transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    /// @notice Mints new tokens for the given account. No ETH is transferred. Just increases the balance of an account.
    /// Increases totalSupply and totalMinted.
    /// @param account The account to mint tokens for.
    /// @param amount The amount of tokens to mint.
    function mint(address account, uint256 amount) public virtual override {
        totalMinted += amount;
        super.mint(account, amount);
    }

    /// @notice Burns tokens from the given account. No ETH is transferred. Just decreases the balance of an account.
    /// Reduces totalSupply and totalMinted.
    /// @param account The account to burn tokens from.
    /// @param amount The amount of tokens to burn.
    function burn(address account, uint256 amount) public virtual override {
        super.burn(account, amount);
        require(amount <= totalMinted, "MockWETH: burn amount exceeds total minted amount");
        totalMinted -= amount;
    }
}
