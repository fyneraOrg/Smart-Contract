# Fynera Token

FYNERA (FYR) is an ERC20 token with multisig governance, controlled blacklist, fee-free whitelist, and proposal-based mint management.

## Key features

- ERC20 standard with `approve`, `increaseAllowance`, and `decreaseAllowance`
- Transaction pause and unpause (`pause` / `unpause`)
- Variable percentage fee management (max 5%)
- Multisig with difference between owner multisig and normal multisig
- Whitelist/blacklist for access control and fee-free
- Minting via proposals (governance) with quorum
- Batch cleanup of expired proposals
- Reentrancy protection via `ReentrancyGuard`

## Deploy

1. Enter the `treasury` address and the owner + normal `multisig` wallets.
2. Deploy the contract.
3. Perform whitelist and blacklist setup via owner.

## Usage

- Transfer: `transfer(address to, uint256 amount)`
- TransferFrom: `transferFrom(address from, address to, uint256 amount)`
- Approve: `approve(address spender, uint256 amount)`
- Increase/Decrease allowance: `increaseAllowance` / `decreaseAllowance`
- Governance: `pause`, `unpause`, `updateFee`, `updateTreasury`
- Multisig: `setMultisig`, `revokeMultisig`
- Blacklist / Whitelist: `setBlacklist`, `setWhitelist`

## License

MIT
