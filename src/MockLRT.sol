// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockLRT {
    string public name = "Mock Liquid Restaking Token";
    string public symbol = "mLRT";
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
    }

    function maliciousMint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
    }
}
