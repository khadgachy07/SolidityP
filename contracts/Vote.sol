// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract cityPoll{
    struct City{
        string cityName;
        uint256 vote;
    }

    mapping (uint256 => City) public cities;
    mapping (address => bool) hasVoted;

    address owner;
    uint256 public cityCount = 0;

    constructor() {
        owner = msg.sender;
        cities[cityCount] = City("Kathmandu",0);
        cityCount++;
    }

    function addCity(string memory _cityName) public{
        cities[cityCount] = City(_cityName,0);
        cityCount ++;
    }

    function vote(uint256 cityID) public {
        City storage myVote = cities[cityID];
        myVote.vote ++;
    }

    function getCity(uint256 cityID) public view returns(string memory){
        City storage myCity = cities[cityID];
        return myCity.cityName;
    }

     function getVote(uint256 cityID) public view returns (uint256) {
         City storage myCity = cities[cityID];
         return myCity.vote;
     }
}
