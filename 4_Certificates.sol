pragma solidity ^0.5.11;

contract Certificates {
    mapping(string=>bool) private certificateHashes;
    address contractOwner = msg.sender;
    
    function add(string memory _hash) public {
        require(msg.sender == contractOwner);
        certificateHashes[_hash]=true;
    }
    
    function verify(string memory _hash) public view returns(bool) {
        return certificateHashes[_hash];
    }
}