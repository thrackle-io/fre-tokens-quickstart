// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/QuickstartERC20.sol";

contract QuickstartERC20Test is Test {
    QuickstartERC20 token;
    address admin = address(0xE4F53F8aD1EB9B8A556ccF363a2389D59447a6df); // Test admin address
    address user1 = address(2);
    address user2 = address(3);

    function setUp() public {
        token = new QuickstartERC20("QuickstartToken", "QTK", admin);
    }

    function testInitialSupply() public view {
        // Initial supply should be zero since no tokens have been minted
        assertEq(token.totalSupply(), 0);
    }

    function testMint() public {
        // Test that minting works
        vm.prank(admin);
        token.mint(user1, 1000 * 10 ** 18);
        assertEq(token.balanceOf(user1), 1000 * 10 ** 18);
    }

    function testTransfer() public {
        // Test transferring tokens
        vm.prank(admin);
        token.mint(user1, 1000 * 10 ** 18);

        vm.prank(user1);
        token.transfer(user2, 500 * 10 ** 18);

        assertEq(token.balanceOf(user1), 500 * 10 ** 18);
        assertEq(token.balanceOf(user2), 500 * 10 ** 18);
    }

    function testTransferFailsWithoutBalance() public {
        // Test that a transfer without enough balance fails
        vm.prank(user1);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        token.transfer(user2, 500 * 10 ** 18);
    }

    function testHandleFees() public {
        // Add test logic for handling fees
        // You can add more complex fee testing based on your fee-handling logic
    }
}
