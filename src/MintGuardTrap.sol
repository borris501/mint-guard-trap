// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

// Minimal interface to fetch total supply
interface ILRT {
    function totalSupply() external view returns (uint256);
}

contract MintGuardTrap is ITrap {
    // Hardcoding the target to ensure "No Storage" and "Self-Sufficient Collection"
    address public constant TARGET_LRT = 0x7562dE036ae83CFa24Ee0aFC944f7E4ecFBcB94B;

    function collect() external view override returns (bytes memory) {
        // ACTUALLY collecting the signal here
        uint256 supply = ILRT(TARGET_LRT).totalSupply();
        return abi.encode(supply);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // Data length guard
        if (data.length == 0 || data[0].length == 0) return (false, bytes(""));

        // Decode the signal we collected in the function above
        uint256 currentSupply = abi.decode(data[0], (uint256));
        
        // Trigger if supply > 1000 ETH (assuming 18 decimals)
        if (currentSupply > 1000 ether) {
            return (true, abi.encode(currentSupply));
        }

        return (false, bytes(""));
    }
}
