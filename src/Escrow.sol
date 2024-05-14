// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Escrow {
    //declare the storage variables
    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address payable _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function approve() external {
        // this function approves the contract and transfers the remaining balance to the beneficiary
        (bool success, ) = beneficiary.call{value: address(this).balance}("");
        require(success);
    }
}
