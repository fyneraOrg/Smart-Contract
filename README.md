# ERC20 Token Base Contract

This repository contains a standard ERC20 token implementation in Solidity (version ^0.8.24) with basic minting and burning functionality. It can be used as a base for creating your own custom ERC20 token.

## Overview

The contract implements the ERC20 standard interface and provides the following features:

- Standard ERC20 **events**: `Transfer` and `Approval`.
- Core ERC20 functions: `transfer`, `transferFrom`, `approve`, `allowance`, `increaseAllowance`, `decreaseAllowance`.
- Internal functions for **minting** (`_mint`) and **burning** (`_burn`) tokens.
- Built-in **balance and allowance management**.
- Solidity 0.8+ ensures protection against integer overflow and underflow.

## Token Properties

- **Name**: Defined during contract deployment.
- **Symbol**: Defined during contract deployment.
- **Decimals**: Fixed at 18.
- **Total Supply**: Tracked internally and updated with mint/burn operations.

## Contract Structure

ERC20/
│
├── ERC20.sol # Main ERC20 implementation
├── Context.sol # Context helper for msg.sender and msg.data
└── README.md # Project documentation


## Usage

- **Deploying the Token:** Provide the token `name` and `symbol` in the constructor.
- **Minting Tokens:** Use `_mint(account, amount)` internally to create new tokens.
- **Burning Tokens:** Use `_burn(account, amount)` internally to remove tokens.
- **Transfers:** Use `transfer` or `transferFrom` to move tokens between accounts.
- **Allowances:** Use `approve`, `increaseAllowance`, or `decreaseAllowance` to manage delegated spending.

## Events

- **Transfer(address from, address to, uint256 value)**  
  Emitted on transfers and mint/burn actions.

- **Approval(address owner, address spender, uint256 value)**  
  Emitted when allowances are set or updated.

## Security

- Solidity 0.8+ provides automatic checks for arithmetic underflow and overflow.
- Transfers and approvals check for zero addresses.
- Minting and burning require valid account addresses.

## License

This project is licensed under the MIT License.

