pragma solidity ^0.5.11;

contract SafeMath{
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "Overflowh: addition");

        return c;
    }
    
    function substract(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Underflow: subtraction");
        uint256 c = a - b;

        return c;
    }
    
    function multiply(uint256 a, uint256 b) internal pure returns (uint256) {
        
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "Overflow: multiplication");

        return c;
    }
    
    function divide(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "Division by zero");
        uint256 c = a / b;
        return c;
    }
    
}

contract Owned {
    
    address private owner;
    
    constructor() internal {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require( owner == msg.sender, "Caller is not the owner");
        _;
    }
    
    function transferOwner(address _newOwner) public onlyOwner {
        _transferOwner(_newOwner);
    }
    
    function renounceOwnership() public onlyOwner {
        owner = address(0);
    }
    
    function _transferOwner(address _newOwner) internal {
        require(_newOwner != address(0), "Ownable: new owner is the zero address");
        owner = _newOwner;
    }
    
}

contract Inheritance is SafeMath, Owned {
    int256 public stateInteger = 0;
    uint256 public lastStateChange = 0;
    
    event LogChange(uint256 stateInteger, uint256 lastStateChange);
    
    function changeState() public onlyOwner {
        
        uint256  _stateInteger = add( uint256(stateInteger) , (now % 256));
        uint256 timeSinceLastChange;
        
        if (lastStateChange == 0) {
            timeSinceLastChange = 1;
        } else {
            timeSinceLastChange = substract(now, lastStateChange);
        }
        
        _stateInteger = multiply( timeSinceLastChange,_stateInteger);
        _stateInteger = substract(_stateInteger, block.gaslimit);

        stateInteger = int256(_stateInteger);
        lastStateChange = now;
        
        emit LogChange(_stateInteger, now);
        
    }
}