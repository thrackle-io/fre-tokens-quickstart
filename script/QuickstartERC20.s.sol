// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/QuickstartERC20.sol";

contract DeployQuickstartERC20 is Script {
    function run() external {
        // Define parameters for token deployment
        string memory tokenName = "QuickstartToken";
        string memory tokenSymbol = "QTK";
        address tokenAdmin = vm.envAddress("TOKEN_ADMIN");

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
