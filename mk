// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GuessGame {
    address public owner;
    uint256 private secret;
    bool public isActive;

    event GameStarted(uint256);
    event GuessAttempt(address indexed player, uint256 guess, bool success);

    constructor() {
        owner = msg.sender;
    }

    function start() external onlyOwner {
        secret = (block.prevrandao + block.timestamp) % 100 + 1;
        isActive = true;
        emit GameStarted(secret);
    }

    function guess(uint256 n) external returns (bool) {
        require(isActive, "game not active");
        bool ok = n == secret;
        if (ok) isActive = false;
        emit GuessAttempt(msg.sender, n, ok);
        return ok;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }
}
