pragma solidity ^0.5.11;

contract Deposit {
    address payable public contractOwner;
    
    constructor(address payable _owner) public {
        contractOwner= _owner;
    }
    
    modifier ownerOnly() {
        require(msg.sender == contractOwner, "The caller needs to be contract owner");
        _;
    }
    
    function deposit() payable public {
        
    }
    
    function get() view public returns(uint) {
        return address(this).balance;
    }
    
    function send(address payable _to, uint _amount) public ownerOnly {
        require(_to != address(0), "Unfortunately, if the parameters were omitted, it would be 0 here.");
        require(_amount > 0, "Surely nothing to do here if nothing to withdraw.");
        _to.transfer(_amount);
        selfdestruct(contractOwner);
    }
}