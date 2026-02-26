// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract MintGuardTrap is ITrap {
    // Check: No storage variables present

    function collect() external view override returns (bytes memory) {
        // We will pass the MockLRT address via the planner, 
        // but for this example, we'll assume it's decoded from data if needed.
        // For simplicity in this logic, we monitor one target.
        return abi.encode(); 
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // RULE 3: DATA LENGTH GUARD
        if (data.length == 0 || data[0].length == 0) return (false, bytes(""));

        // data[0] contains the abi.encoded total supply we collected
        uint256 currentSupply = abi.decode(data[0], (uint256));
        
        // In a real scenario, we'd compare data[0] vs data[1].
        // For this 1-vector threshold simulation: trigger if supply > 1000 ether
        if (currentSupply > 1000 ether) {
            return (true, abi.encode(currentSupply));
        }

        return (false, bytes(""));
    }
}
