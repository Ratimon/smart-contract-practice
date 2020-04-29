pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

contract PlanetEarth {

    enum Continent {
        Africa,
        Antarctica,
        NorthAmerica,
        SouthAmerica,
        Asia,
        Ociania,
        Europe
    }
    
    struct Country {
        string name;
        Continent continent;
        uint256 population;
    }
    
    Country[] public europeanCountries;
    
    mapping(string=> string) public capitalIn;
    uint256 countryCount;
    
    modifier europeanOnly(Continent _continent) {
        require(uint(_continent) == uint(Continent.Europe),"Please add country in Europe only.");
        _;
    }
    
    function addCountry(string memory _name, Continent _continent, uint256 _population) public europeanOnly(_continent) {
        Country memory newCountry = Country(_name, _continent, _population);
        europeanCountries.push(newCountry);
        countryCount++;
    }
    
    function addCapital(string memory _capitalName, string memory _countryName) public {
        capitalIn[_countryName]=_capitalName;
    }
    
    function getCapitalByName(string memory _countryName) public view returns(string memory) {
        string memory capital = capitalIn[_countryName];
        return capital;
    }
    
    function removeCapital(string memory _countryName) public {
        delete capitalIn[_countryName];
    }
    
    function getAllEuropeanCountry() public view returns (Country[] memory){
        Country[] memory countries = new Country[](countryCount);
        for (uint i = 0; i < countryCount; i++) {
            countries[i] = europeanCountries[i];
        }
        return countries;       
    }
    
    function getContinentKeyByValue(Continent _continent) public pure returns(string memory) {
        if (uint(Continent.Africa) == uint(_continent)) return "Africa";
        if (uint(Continent.Antarctica) == uint(_continent)) return "Antarctica";
        if (uint(Continent.NorthAmerica) == uint(_continent)) return "NorthAmerica";
        if (uint(Continent.SouthAmerica) == uint(_continent)) return "SouthAmerica";
        if (uint(Continent.Asia) == uint(_continent)) return "Asia";
        if (uint(Continent.Ociania) == uint(_continent)) return "Ociania";
        if (uint(Continent.Europe) == uint(_continent)) return "Europe";
        return "";
  }
    
}