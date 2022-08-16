// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract StarterContract{

    address owner;

    struct Person{
        uint age;
        string name;
        address contract_address;
    }

    bytes32[] public hashPerson;

    Person[] public Creators;

    mapping(bytes32 => Person) public personsHash;

    mapping(string => Person) namePerson;

    constructor (){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require( msg.sender == owner,"Caller must be owner");
        _;
    }

    modifier checkBalance{
        require( address(msg.sender).balance >= 0.005 ether,"Should have more than 500 eth" );
        _;
    }

    function addCreator(uint _age, string memory _name, address _contractAddress) public checkBalance{
        Person memory person;

        person.age = _age;
        person.name = _name;
        person.contract_address = _contractAddress;

        Creators.push(person);

        bytes32 hash = getHash(_age,_name,_contractAddress);
        hashPerson.push(hash);
        personsHash[hash] = person;

        namePerson[_name] = person;
    }

    function getHash(uint _age, string memory _name, address _contactAddress) internal pure returns(bytes32) {
        return keccak256(abi.encode(_age, _name, _contactAddress));
    }

    function getCretors() public view returns(Person[] memory){
        return Creators;
    }

    function getPerson(string memory _name) public view onlyOwner returns(Person memory){
       return namePerson[_name];
    }


}