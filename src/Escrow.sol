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

    error unAuthorized();
    event Approved(uint);

    function approve() external {
        uint balance = address(this).balance; //get the balance of the contract

        (bool success, ) = beneficiary.call{value: address(this).balance}("");
        require(success);

        if (msg.sender != arbiter) revert unAuthorized(); //if anyone other than the arbiter tries to approve the transaction, revert

        emit Approved(balance); //emit  the event
    }
}
