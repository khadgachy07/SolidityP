// SPDX-License-Identifier: UNLICENCED

pragma solidity ^0.8.0;

contract HotelRoom{
    enum Statuses{Vaccant, Occupied}
    Statuses currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;
    
    constructor() {
        owner = payable (msg.sender);
        currentStatus = Statuses.Vaccant;
    }

    modifier onlyVaccant{
        // Check Status
        require(currentStatus == Statuses.Vaccant,"Currently Occupied");
        _;
    }
    modifier costs(uint _amount){
        // Check price 
        require(msg.value >= _amount,"Not enough ether provided");
        _;
    }

    receive()external payable onlyVaccant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender,msg.value);
    }
}