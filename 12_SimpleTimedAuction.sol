pragma solidity ^0.5.11;

contract SimpleTimedAunction {
    
    address public contractOwner;
    uint256 startTime;
    uint256 durationTime = 1 minutes;
    uint256 public tokenToSell;
    
    event LogBuy(address indexed buyer, uint256 amount);
    
    struct Buyer{
        uint256 amount;
        bool bought;
    }
    mapping(address => Buyer) public buyers;
    bool ended;
    
    constructor(uint256 _tokenToSell) public {
        contractOwner = msg.sender;
        startTime = now;
        tokenToSell = _tokenToSell;
    }
    
    function buyTokens(uint256 _amount) public {
        require( now <= startTime+ durationTime, "Auction already ended.");
        require( 0 <= _amount, "The amount should be positive");
        require( _amount <= tokenToSell , " The token reserved is less than your proposal one");
        
        Buyer storage bidder = buyers[msg.sender];
        bidder.amount += _amount;
        tokenToSell -= _amount;
        emit LogBuy(msg.sender, _amount);
    }
    
    
    function releaseToken()  public  {
        
        require( startTime+ durationTime < now, "Auction not yet ended.");
        Buyer storage bidder = buyers[msg.sender];
        bool isBought = bidder.bought;
        require(isBought == false, "You are not in the bidder lists ,or you have bought already token");
        
        bidder.bought = true;
        
    }
    
    function boughtTokenOf(address _address) public view returns(uint256) {
        require( startTime+ durationTime < now, "Auction not yet ended.");
        Buyer storage buyer = buyers[_address];
        bool isBought = buyer.bought;
        require(isBought, "The token is still not released. Please call releaseToken() beforehand");
        return buyer.amount;
    }
    
}