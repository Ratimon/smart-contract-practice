pragma solidity ^0.5.11;

contract PreviousInvoker {
    address private previousinvoker;
    
    constructor() public {
 
    }
    
    function invoke() public returns ( bool, address) {
        address result = previousinvoker;
        previousinvoker = msg.sender;
        return (result != address(0x0), result);
    }
   
}