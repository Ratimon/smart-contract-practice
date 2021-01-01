pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

contract Capitol {
    
    address public contractOwner;
    uint256 secretSeed;
    enum Gender {Male, Female}
    
    struct Person{
        uint256 age;
        Gender gender;
    }
    
    Person[] public people;
    Person[] public competitors;

    uint256 startDate;
    uint256 gameDuration = 5 minutes;
    bool isDateSet;
    
    event LogAdd(uint256 age, Gender gendert);
    event LogChoose(Person maleCompetitpr, Person femaleCompetitpr);


    constructor(uint256 _secretSeed) public {
        secretSeed = _secretSeed;
        contractOwner = msg.sender;
    }
    
    modifier ownerOnly() {
        require(msg.sender == contractOwner, "The caller needs to be contract owner");
        _;
    }
    
    modifier gameHasEndedOnly() {
        require(isDateSet, "The start date has not been set");
        require(startDate + gameDuration < now, "The game has not yet ended");
        _;
    }
    
    function add(uint256 _age, Gender _gender ) public ownerOnly {
       people.push(Person( _age, _gender));
       emit LogAdd(_age, _gender);
    }
    
    function choose() public ownerOnly {
        require(competitors.length == 0,"The pair can be chosen only once");
        
        Person[] memory _candidates = _filter12to18Age();
        Person[] memory _males = _filterGender(_candidates, Gender.Male);
        Person[] memory _females = _filterGender(_candidates, Gender.Female);
        uint256 randomId = _pseudoRandom(0, _males.length-1);
        competitors.push(_males[randomId]);
        randomId = _pseudoRandom(0, _females.length-1);
        competitors.push(_females[randomId]);
        emit LogChoose(_males[randomId], _females[randomId]);
    }
    
    function setDate(uint256 _daysAfter) public ownerOnly {
        require(isDateSet == false, "Date can be set only once");
        require(competitors.length==2, "A boy and a girl are not yet choosen");
        
        startDate = now + _daysAfter*1 days;
        isDateSet=true;
    }
    
    function checkIfAlive() public gameHasEndedOnly view returns(string memory) {
        uint randomValue = _pseudoRandom(0, 1);
        if(randomValue == 0)
            return "Dead";
        else
            return "Alive";
    }
    
    function reset(uint256 _secretSeed) public ownerOnly gameHasEndedOnly {
        secretSeed = _secretSeed;
        isDateSet = false;
        delete competitors;
    }
    
    function boysAndGirlsCount() public view returns(uint256){
        return people.length;
    }
    
    function _filter12to18Age() private view returns(Person[] memory) {
        uint256 length = 0;
        
        for(uint i = 0; i < people.length; i++) {
            if(11 < people[i].age && people[i].age < 19) {
                length++;
            }
        }        
        
        Person[] memory candidates = new Person[](length);
        uint256 id = 0;
        
        for(uint i = 0; i < people.length; i++) {
            if(11 < people[i].age && people[i].age < 19) {
                candidates[id] = people[i];
                id++;
            }
        }
        return candidates;
    }    

    function _filterGender(Person[] memory _people, Gender _gender) private pure returns(Person[] memory) {
        
        uint256 length = 0;
        
        for(uint i = 0; i < _people.length; i++) {
            if(uint(_people[i].gender) == uint(_gender)) {
                length++;
            }
        } 
        
        Person[] memory filtered = new Person[](length);
        uint256 id = 0;
        for(uint i = 0; i < _people.length; i++) {
            if(uint(_people[i].gender) == uint(_gender) ) {
                filtered[id] = _people[i];
                id++;
            }
        }
        return filtered;        
    }  
    
    function _pseudoRandom(uint start, uint end) private view returns (uint) {
        bytes32 randSeed = keccak256(abi.encodePacked(secretSeed,  block.timestamp, block.coinbase, block.difficulty, block.number));
        uint range = end - start + 1;
        uint randVal = start + uint256(randSeed) % range;
        return randVal;
    }
    
}