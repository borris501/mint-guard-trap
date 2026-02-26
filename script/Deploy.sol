// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MockLRT.sol";
import "../src/MintGuardResponse.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MockLRT mock = new MockLRT();
        // We authorize the Drosera Executor address for Hoodi
        MintGuardResponse response = new MintGuardResponse(0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D);

        console.log("MockLRT deployed at:", address(mock));
        console.log("Response deployed at:", address(response));

        vm.stopBroadcast();
    }
}
