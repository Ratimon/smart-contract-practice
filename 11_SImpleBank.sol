pragma solidity ^0.5.11;

contract SimpleBank{
    address public contractOwner;
    mapping(address=>uint256) public balances;
    
    event LogDeposit(address indexed sender, uint256 amount);
    event LogWithdrawn(address indexed withdrawer, uint256 amount);

    constructor() public {
        contractOwner=msg.sender;
    }
    
    function deposit() payable public returns(uint256) {
        require(msg.value > 0, 'Amount deposited must be bigger than 0');
        balances[msg.sender] += msg.value;
        emit LogWithdrawn(msg.sender, msg.value);
        
        return balances[msg.sender];
    }
    
    function withdraw( uint256 _amount) public returns(uint256) {
        uint256 currentBalance = balances[msg.sender];
        require( currentBalance >= _amount, 'The account must have enough balance.');
        require(msg.sender.balance + _amount >= msg.sender.balance, 'overflow');
        
        balances[msg.sender] -= _amount;
        emit LogWithdrawn(msg.sender, _amount);
        msg.sender.transfer(_amount);
        
        return balances[msg.sender];
    }
    
    function getBalance() public view returns(uint256) {
        return balances[msg.sender];
    }
    

}