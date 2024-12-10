// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/QuickstartERC721.sol";

contract DeployQuickstartERC721 is Script {
    function run() external {
        // Define parameters for token deployment
        string memory tokenName = "Quickstart NFT";
        string memory tokenSymbol = "QTKNFT";
        address tokenAdmin = 0xE4F53F8aD1EB9B8A556ccF363a2389D59447a6df; // Dev Thrackle
        string
            memory baseUri = "https://sapphire-controlled-herring-537.mypinata.cloud/ipfs/Qma1jHG1Jy718KcqfYYCxDkAe65xaC6AscRnDG33SbbXV4";

        vm.startBroadcast();
        QuickstartERC721 token = new QuickstartERC721(
            tokenName,
            tokenSymbol,
            tokenAdmin,
            baseUri
        );
        vm.stopBroadcast();

        console.log("QuickstartERC721 deployed at:", address(token));
    }
}
