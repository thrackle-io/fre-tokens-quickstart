// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/OracleDenied.sol";

contract DeployOracleDenied is Script {
    function run() external {
        // Define parameters for oracle deployment
        address oracleAdmin = 0xE4F53F8aD1EB9B8A556ccF363a2389D59447a6df; // Dev Thrackle

        vm.startBroadcast();
        OracleDenied oracle = new OracleDenied(oracleAdmin);
        vm.stopBroadcast();

        console.log("OracleDenied deployed at:", address(oracle));
    }
}
