pragma solidity ^0.5.11;

 contract PetSanctuary {
     
    address public sanctuaryOwner;
    enum AnimalKind {
        Fish,
        Cat,
        Dog,
        Rabbit,
        Parrot
    }
    
    mapping(uint256 => uint256) public animalCountOf;
    enum Gender {Male, Female}
    struct Person{
        uint256 age;
        Gender gender;
        AnimalKind adoptedAnimal;
        bool hasAdopted;
        uint256 deadline;
    }

    event LogAdd(AnimalKind animalKind, uint256 animalCount);
    event LogBuy(uint256 _personAge, Gender _personGender, AnimalKind _animalKind, bool hasAdopted, uint256 deadline, uint256 animalLeft);
    event LogGiveAnimalBack(AnimalKind _animalKind, uint256 animalLeft);

    
    mapping(address=>Person) public People;

    constructor() public {
        sanctuaryOwner= msg.sender;
    }
    
    modifier sanctuaryOwnerOnly() {
        require(sanctuaryOwner==msg.sender, "only the owner can give shelter to animals in the sanctuary");
        _;
    }
    
    function add(AnimalKind _animalKind, uint256 _howManyPieces) public sanctuaryOwnerOnly {
       animalCountOf[uint256(_animalKind)] += _howManyPieces;
       emit LogAdd(_animalKind, _howManyPieces);
    }
    
    function buy(uint256 _personAge, Gender _personGender, AnimalKind _animalKind) public{
        require( People[msg.sender].hasAdopted == false, "You have animal adopted");
        
        mapping(uint256 => uint256) storage animalLeftOf = animalCountOf;
        require(animalLeftOf[uint256(_animalKind)] > 0, "There are no animal left");
        animalLeftOf[uint256(_animalKind)]--;
        
         if ( uint(Gender.Male) == uint(_personGender) ) {

             if(
                 
                    (uint(_animalKind) !=  uint(AnimalKind.Dog)) &&
                    (uint(_animalKind) !=  uint(AnimalKind.Fish))                 
                 ) {
                 revert("Men can only buy dog and fish");
             }
         }  else {
             if(uint(_animalKind)== uint(AnimalKind.Cat) && _personAge<40 ) {
                 revert("You are under 40, so you are not allowed to buy a cat");
             }
         }
         
         People[msg.sender] = Person(_personAge, _personGender, _animalKind, true, now+ 5 minutes);
         emit LogBuy(_personAge, _personGender, _animalKind, true, now+ 5 minutes, animalLeftOf[uint256(_animalKind)]);
    }
    
    function giveAnimalBack(AnimalKind _animalKind) public {
        Person storage adopter = People[msg.sender];
        require( uint(_animalKind) == uint(adopter.adoptedAnimal), "You request wrong kind of animal" );
        require( adopter.hasAdopted , "You need to adopt animal before giving back");
        require( now < adopter.deadline , "The deadline has passed");
        
        delete People[msg.sender];
        
        mapping(uint256 => uint256) storage animalLeftOf = animalCountOf;
        animalLeftOf[uint256(_animalKind)]++;
        emit LogGiveAnimalBack(_animalKind, animalLeftOf[uint256(_animalKind)]);
    }
     
 }