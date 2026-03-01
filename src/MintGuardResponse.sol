// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MintGuardResponse {
    address public owner;
    mapping(address => bool) public authorizedOperators;

    event EmergencyAlert(uint256 supply);
    event OperatorUpdated(address operator, bool status);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier onlyOperator() {
        require(authorizedOperators[msg.sender], "not authorized");
        _;
    }

    constructor(address initialOperator) {
        owner = msg.sender;
        authorizedOperators[initialOperator] = true;
        emit OperatorUpdated(initialOperator, true);
    }

    function setOperator(address operator, bool status) external onlyOwner {
        authorizedOperators[operator] = status;
        emit OperatorUpdated(operator, status);
    }

    function respond(uint256 supply) external onlyOperator {
        // Emergency logic here
        emit EmergencyAlert(supply);
    }
}
