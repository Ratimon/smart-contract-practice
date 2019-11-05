pragma solidity ^0.5.11;

contract Incrementor {
    uint private value= 0;
    
    function get() view public returns(uint){
        return value;
    }
    
    function increment(uint _delta) public {
        value += _delta;
    }
    
}