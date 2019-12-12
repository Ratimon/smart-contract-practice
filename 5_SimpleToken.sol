pragma solidity ^0.5.11;

contract SimpleToken {
    mapping(address=>uint256) public balanceOf;
    event LogTransferd(address indexed sender, address indexed to, uint256 vale);
    
    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
    }
    
    function transfer(address _to, uint256 _value) public {
        require( balanceOf[msg.sender] >= _value, "The number of tokens for transfer must be less than existing one");
        uint256 recipientBalance=balanceOf[_to];
        require( recipientBalance + _value >= recipientBalance, "overflow");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit LogTransferd(msg.sender, _to, _value);
    }
}