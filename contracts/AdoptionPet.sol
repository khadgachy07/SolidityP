// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Adoption{

    address public owner;

    uint public adoptionCount;

    struct adoptors{
        string name;
        uint age;
        uint petID;
        address adoptor;
    }

    mapping(uint => adoptors) public petToAddress;

    adoptors public people;

    constructor(){
        adoptionCount = 0;
        owner = msg.sender;
    }
    
    function adopt(uint petID,string memory _name,uint _age) public {
        require(petID >= 0 && petID <= 15,'PetID should be between 0 and 15');
        require(msg.sender != owner);
        adoptors storage newpeople = people;
        newpeople.name = _name;
        newpeople.age = _age;
        newpeople.petID = petID;
        newpeople.adoptor = msg.sender;
        adoptionCount ++;
        petToAddress[petID] = people;
    }

}