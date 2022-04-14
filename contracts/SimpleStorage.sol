// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

contract SimpleStorage {

    // this will get initialized to 0!
    uint256 favoriteNumber;
    
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // view and pure
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
}