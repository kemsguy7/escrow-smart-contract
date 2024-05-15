// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address payable beneficiary = payable(address(4));

    function setUp() public {
        hoax(depositor);
        escrow = new Escrow{value: 1 ether}(arbiter, beneficiary);

        vm.prank(arbiter);
        escrow.approve();
    }

    function testBalance() public view {
        assertEq(beneficiary.balance, 1 ether);
    }

    error unAuthorized();

    function approve() external {
        (bool success, ) = beneficiary.call{value: address(this).balance}("");
        require(success);

        if (msg.sender != arbiter) revert unAuthorized(); //if anyone other than the arbiter tries to approve the transaction, revert
    }
}
