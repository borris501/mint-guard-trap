// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MockLRT.sol";

contract AttackScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // Your live MockLRT address
        address lrtAddress = 0x04aB212043c1DB35389Ce16821bc947E608154AC;

        vm.startBroadcast(deployerPrivateKey);

        MockLRT(lrtAddress).maliciousMint(2000 ether);

        console.log("Malicious mint complete. Total Supply is now over 2000 ETH.");
        vm.stopBroadcast();
    }
}
