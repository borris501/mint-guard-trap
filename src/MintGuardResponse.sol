// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MintGuardResponse {
    event EmergencyAlert(uint256 supplyAtTrigger, uint256 timestamp);

    mapping(address => bool) public authorizedOperators;

    modifier onlyOperator() {
        require(authorizedOperators[msg.sender], "not authorized");
        _;
    }

    constructor(address operator) {
        authorizedOperators[operator] = true;
    }

    // This matches the abi.encode(currentSupply) from the Trap
    function respond(uint256 supplyAtTrigger) external onlyOperator {
        emit EmergencyAlert(supplyAtTrigger, block.timestamp);
        // In production, this would call pause() on the LRT contract
    }
}
