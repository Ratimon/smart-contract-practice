pragma solidity ^0.5.11;

contract Diary{
    string[] facts;
    address contractOwner = msg.sender;
    mapping(address=>bool) whiteLists;
    
    constructor() public {
        whiteLists[msg.sender]=true;
        whiteLists[0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C]=true;
    }
    
    modifier ownerOnly() {
        require(msg.sender == contractOwner, "The caller needs to be contract owner");
        _;
    }

    modifier approvedOnly() {
        require(whiteLists[msg.sender] == true, "The caller needs to be approved");
        _;
    }
    
    function addFact(string calldata _fact) external ownerOnly {
        facts.push(_fact);
    }
    
    function getFact(uint _index) view external approvedOnly returns( string memory) {
        return facts[_index];
    }
    
    function count() view public returns(uint) {
        return facts.length;
    }
}