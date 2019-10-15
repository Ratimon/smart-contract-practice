pragma solidity ^0.5.11;

contract SimpleStorage {
    uint private storedData;
    
    function set(uint _storedData) public {
        storedData = _storedData;
    }
    function get() view public returns(uint){
        return storedData;
    }
}