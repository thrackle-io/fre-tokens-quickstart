// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/QuickstartERC20.sol";

contract DeployQuickstartERC20 is Script {
    function run() external {
        // Define parameters for token deployment
        string memory tokenName = "QuickstartToken";
        string memory tokenSymbol = "QTK";
        //address tokenAdmin = 0xE4F53F8aD1EB9B8A556ccF363a2389D59447a6df; // Dev Thrackle
        address tokenAdmin = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

        vm.startBroadcast();
        QuickstartERC20 token = new QuickstartERC20(
            tokenName,
            tokenSymbol,
            tokenAdmin
        );
        vm.stopBroadcast();

        console.log("QuickstartERC20 deployed at:", address(token));
    }
}
