pragma solidity ^0.8.0;

contract Conditional{
    //Loop 
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];

    // address public owner = msg.sender;
    address public owner;

    constructor () public {
        owner = msg.sender;
    }

    function countEvenNumb() public view returns (uint){
        uint count = 0;

        for( uint i = 0; i < numbers.length; i++){
            if(isEvenNumb(numbers[i])){
                count ++;
            }
        }
        return count;
    }

    // conditional
    function isEvenNumb(uint _number) public pure returns (bool){
        if (_number % 2 == 0){
            return true;
        }
        else{
            return false;
        }
    }

    function isOwner() public view returns (bool){
        return (msg.sender == owner);
    }

}