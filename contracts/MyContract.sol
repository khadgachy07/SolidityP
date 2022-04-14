pragma solidity ^0.8.0;

contract MyContract {
       //State Variables
        int public myInt = 0;
        uint public myUint = 1;
        uint256 public myUint256 = 2; 
        uint8 public myUint8 = 3;
        string public myString = 'Hello World';
        bytes32 public myBytes32 = 'Hello Everyone!';
        address public myAddress = 0xE6107C0971d00663c64f7Bdd29426c6eB22559a1;

        // Struct are Like objects for Solidity
        struct MyStruct {
            uint a;
            string b;
        }

        MyStruct public myStruct = MyStruct(1,'Hello World');

       // Local Variables
       function getValue() public pure returns(uint){
           uint value = 1;
           return value;
       }
} 