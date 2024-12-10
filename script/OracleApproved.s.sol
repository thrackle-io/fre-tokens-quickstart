// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/OracleApproved.sol";

contract DeployOracleApproved is Script {
    function run() external {
        // Define parameters for oracle deployment
        address oracleAdmin = 0xE4F53F8aD1EB9B8A556ccF363a2389D59447a6df; // Dev Thrackle

        vm.startBroadcast();
        OracleApproved oracle = new OracleApproved(oracleAdmin);
        vm.stopBroadcast();

        console.log("OracleApproved deployed at:", address(oracle));
    }
}
