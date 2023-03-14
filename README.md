# Coinflakes DAO

## ~ Mock versions of ERC20 tokens ~

### Project Summary

This project provides mock ERC20 tokens implemented in Solidity for testing smart contracts without deploying real tokens on the Ethereum blockchain.

:red_circle: **Important note:** :red_circle:

These tokens are not intended for production use unless you specifically
require tokens without any money printing permissions. They are meant for
testing purposes only.

#### MockERC20

MockERC20 is an implementation of the ERC20 interface with the following differences:

- tokens can be minted in any amount by anyone (no permission checks)
- tokens can be burned from any account by anyone (no permission checks)
- decimals can be set to any value (not fixed to 18) in the constructor

#### MockWETH

MockWETH is an implementation of the WETH ("Wrapped Ether") interface with the following differences:

- MockWETH shares the permissionless minting and burning of MockERC20
- MockWETH has a fixed decimals value of 18
- MockWETH has a fixed name and symbol of "Wrapped Ether" and "WETH"
- WETH can only burn tokens which have been minted by the mint() function. Deposits cannot be burned and but do count to the total supply. Deposits must be withdrawn instead of burned.

### Project Structure

- [src](src) - smart contracts.
  - [MockERC20.sol](src/MockERC20.sol) - smart contract for MockERC20.
  - [MockWETH.sol](src/MockWETH.sol) - smart contract for MockWETH.
- [interfaces](interfaces) - interfaces for the smart contracts.
  - [IWETH.sol](src/interfaces/IWETH.sol) - interface for WETH9 contract.

### License

[2023 - MIT License](LICENSE)
