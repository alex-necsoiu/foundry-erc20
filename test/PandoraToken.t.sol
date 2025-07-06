// SPX-License-Identifier: MIT
pragma solidity ^0.8.27;	

import {Test} from "forge-std/Test.sol";
import {PandoraToken} from "../src/PandoraToken.sol";
import {DeployPandoraToken} from "../script/DeployPandoraToken.s.sol";

contract PandoraTokenTest is Test{
    PandoraToken public token;
    DeployPandoraToken public deployer;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    uint256 STARTING_BALANCE = 100 * 10**18; // 100 million tokens with 18 decimals

    function setUp() public {
	deployer = new DeployPandoraToken();
	token = deployer.run();
	vm.prank(msg.sender);
	token.transfer(bob, STARTING_BALANCE);
    }

    function testInitialSupply() public {
	uint256 expectedSupply = 100_000_000 * 10**18; // 100 million tokens with 18 decimals
	assertEq(token.totalSupply(), expectedSupply, "Initial supply should be 100 million tokens");
    }

    function testBobBalance() public {
	assertEq(token.balanceOf(bob), STARTING_BALANCE, "Bob's balance should be 100 million tokens");
    }

    function testNameAndSymbol() public {
	assertEq(token.name(), "PandoraToken", "Token name should be PandoraToken");
	assertEq(token.symbol(), "PT", "Token symbol should be PT");
    }

    function testAllowance() public {
	uint256 allowance = 100;
	vm.prank(bob);   
	// Set allowance for Alice to spend Bob's tokens
	token.approve(alice, allowance);
	vm.prank(alice);
	token.transferFrom(bob, alice, allowance);
	assertEq(token.balanceOf(alice), allowance, "Alice's balance should be equal to the allowance");
	assertEq(token.balanceOf(bob), STARTING_BALANCE - allowance,"bob's balance should be reduced by the allowance");
    }

    function testApprove() public {
        uint256 allowance = 500;
        vm.prank(bob);
        bool success = token.approve(alice, allowance);
        assertTrue(success, "Approve should return true");
        assertEq(token.allowance(bob, alice), allowance, "Allowance should be set correctly");
    }

    function testIncreaseDecreaseAllowance() public {
        uint256 allowance = 1000;
        vm.prank(bob);
        token.approve(alice, allowance);
        vm.prank(bob);
        token.increaseAllowance(alice, 500);
        assertEq(token.allowance(bob, alice), 1500, "Allowance should increase");
        vm.prank(bob);
        token.decreaseAllowance(alice, 200);
        assertEq(token.allowance(bob, alice), 1300, "Allowance should decrease");
    }

    function testTransfer() public {
        uint256 amount = 10 * 10**18;
        vm.prank(bob);
        token.transfer(alice, amount);
        assertEq(token.balanceOf(alice), amount, "Alice should receive tokens");
        assertEq(token.balanceOf(bob), STARTING_BALANCE - amount, "Bob's balance should decrease");
    }

    function testTransferInsufficientBalance() public {
        uint256 amount = 200 * 10**18;
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, amount);
    }

    function testTransferFromWithoutApproval() public {
        uint256 amount = 10 * 10**18;
        vm.prank(alice);
        vm.expectRevert();
        token.transferFrom(bob, alice, amount);
    }

    function testTransferFromWithInsufficientAllowance() public {
        uint256 allowance = 5 * 10**18;
        uint256 amount = 10 * 10**18;
        vm.prank(bob);
        token.approve(alice, allowance);
        vm.prank(alice);
        vm.expectRevert();
        token.transferFrom(bob, alice, amount);
    }

    function testCannotDecreaseAllowanceBelowZero() public {
        vm.prank(bob);
        token.approve(alice, 0);
        vm.prank(bob);
        vm.expectRevert();
        token.decreaseAllowance(alice, 1);
    }

    function testZeroAddressReverts() public {
        uint256 amount = 1 * 10**18;
        // Transfer to zero address
        vm.prank(bob);
        vm.expectRevert();
        token.transfer(address(0), amount);

        // Approve zero address
        vm.prank(bob);
        vm.expectRevert();
        token.approve(address(0), amount);
    }

}