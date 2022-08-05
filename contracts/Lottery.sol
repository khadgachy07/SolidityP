// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract Lottery {
    address public manager;
    address payable[] public participants;

    constructor() {
        manager = msg.sender; 
    }
    
    modifier isOwner{
        require( msg.sender == manager);
        _;
    }

    receive() external payable {
        require(msg.value >= 1 ether);
        participants.push(payable(msg.sender));
    }

    function getBalance() public view isOwner returns (uint){
        return address(this).balance;
    }

    function random() internal view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function selectWinner() public isOwner{ 
        require(participants.length >= 3);   
        uint r = random();
        address payable winner;
        uint l = participants.length;
        uint index = r % l;
        winner = participants[index];
        payable(winner).transfer(address(this).balance);
    }

}