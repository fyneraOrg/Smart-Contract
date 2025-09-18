// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./openzeppelin/Ownable.sol";
import "./openzeppelin/ReentrancyGuard.sol";
import "./openzeppelin/ERC20.sol";

contract KIVRA is ERC20, Ownable, ReentrancyGuard {
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10**18;

    mapping(address => bool) public blacklist;
    mapping(address => bool) public whitelist;
    mapping(address => bool) public isMultisig;
    mapping(address => bool) public isOwnerMultisig;

    uint256 public feePercent = 2;
    address public treasury;
    bool public paused;
    uint256 public lastPauseTimestamp;
    uint256 public constant pauseCooldown = 1 hours;

    event Paused(address indexed by);
    event Unpaused(address indexed by);
    event BlacklistUpdated(address indexed account, bool status);
    event WhitelistUpdated(address indexed account, bool status);
    event FeeUpdated(uint256 newFee);
    event TreasuryUpdated(address newTreasury);
    event MultisigUpdated(address indexed account, bool status, bool ownerPrivileges);

    modifier onlyMultisig() {
        require(isMultisig[msg.sender] || isOwnerMultisig[msg.sender], "Not multisig");
        _;
    }

    modifier notPaused() {
        require(!paused, "Paused");
        _;
    }

    constructor(
        address _treasury,
        address[] memory ownerMultisig,
        address[] memory normalMultisig
    ) ERC20("FYNERA", "FYN") {
        treasury = _treasury;

        for (uint256 i = 0; i < ownerMultisig.length; i++) {
            _setMultisig(ownerMultisig[i], true, true);
        }

        for (uint256 i = 0; i < normalMultisig.length; i++) {
            _setMultisig(normalMultisig[i], true, false);
        }

        _mint(msg.sender, MAX_SUPPLY);
    }

    function _transfer(address from, address to, uint256 amount) internal override {
        require(!blacklist[from] && !blacklist[to], "Blacklisted");
        uint256 fee = whitelist[from] || whitelist[to] ? 0 : (amount * feePercent) / 100;
        uint256 sendAmount = amount - fee;
        super._transfer(from, to, sendAmount);
        if (fee > 0) super._transfer(from, treasury, fee);
    }

    function pause() external onlyOwner {
        require(block.timestamp >= lastPauseTimestamp + pauseCooldown, "Cooldown");
        paused = true;
        lastPauseTimestamp = block.timestamp;
        emit Paused(msg.sender);
    }

    function unpause() external onlyOwner {
        paused = false;
        emit Unpaused(msg.sender);
    }

    function updateFee(uint256 newFee) external onlyOwner {
        require(newFee <= 5, "Max 5%");
        feePercent = newFee;
        emit FeeUpdated(newFee);
    }

    function updateTreasury(address newTreasury) external onlyOwner {
        treasury = newTreasury;
        emit TreasuryUpdated(newTreasury);
    }

    function setWhitelist(address account, bool status) external onlyOwner {
        whitelist[account] = status;
        emit WhitelistUpdated(account, status);
    }

    function setBlacklist(address account, bool status) external onlyOwner {
        blacklist[account] = status;
        emit BlacklistUpdated(account, status);
    }

    function _setMultisig(address account, bool status, bool ownerPrivileges) internal {
        isMultisig[account] = status;
        isOwnerMultisig[account] = ownerPrivileges;
        emit MultisigUpdated(account, status, ownerPrivileges);
    }
}
