// SPDX-License-Identifier: MIT
// Final Version 5.3 - Strict Interface Match
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

interface ILRT {
    function totalSupply() external view returns (uint256);
}

contract MintGuardTrap is ITrap {
    address public constant TARGET_LRT = 0x7562dE036ae83CFa24Ee0aFC944f7E4ecFBcB94B;

    // Matches interface: returns 'bytes memory'
    function collect() external view returns (bytes memory) {
        return abi.encode(ILRT(TARGET_LRT).totalSupply());
    }

    // Matches interface: accepts 'bytes[] calldata'
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        // Since collect returns 'bytes', Drosera wraps it in an array for shouldRespond
        uint256 supply = abi.decode(data[0], (uint256));
        
        // Trigger if supply is 0 or more to verify the pipeline
        if (supply >= 0) {
            return (true, abi.encode(supply));
        }
        return (false, "");
    }

    function shouldAlert(bytes[] calldata) external pure returns (bool, bytes memory) {
        return (false, "");
    }
}
