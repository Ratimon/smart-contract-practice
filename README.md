# smart-contract-practice

## Problem1. SimpleStorageContract

Write a simple contract in Solidity that keeps in the blockchain an integer variable and provide public functions to read it and change it

## Problem2. IncrementorContract

Write a Solidiy contract, as described below:
- The contract holds a certain value
    * value(uint) -> not accessible outside the contract
- Anyone can see the function and read the value o ReyusnsuintProblem 
    * Returns uint
    * Not modifying the state of blockchain!
- Anyone can increment the value
    * increment(uint delta)
    * No output!
- Test and play around with the contract

## Problem3. Previous Invoker

Write a Solidity contract as described below:

- Keep the address of its previous invoker in the persistent storage -> not accessible outside the contract
    * getLastInvoker() à returns (bool, address)
    * true / false – if a previous invoker exists or not
    * The address that has invoked the contract before you
    * Accessible from outside the contract

Add appropriate events for the functions

Test and play around with the contract

## Problem4. Registry of Certificates

Write a simple contract in Solidity that represents a registry of certificates.

- Each certificate has its owner and content calculated as hash
- The registry holds of all valid certificate hashes stored on the blockchain (as string)
- Only the owner can add certificate hashes: add(hash)
- You may use this tool https://emn178.github.io/online-tools/sha3_512.html to calculate hashes
- Anyone can verify а certificate by its hash: verify(hash)

Add appropriate events for the functions

Test and play around with the contract

## Problem5. Simple Token

Write a contract that represents a simple token

- The initial supply must be set at contract’s creation
    *  This amount must be allocated to the address that creates the contract
- You should store the balances of the addresses -> mapping
- Add a functionality that allows for transfer(to, value) of tokens between the address of the contract’s creator and other addresses
    * The number of tokens for transfer must be bigger than 0
    * Check for overflow

Add appropriate events for the functions
Test and play around with the contract

## Problem6. Diary

Alice loves to document facts. In fact, every night before she goes to sleep she loves to remember all the thing which has happened through the day and to write them down in her diary.

Create a Diary contract in Solidity which:

-  Keep in the blockchain a string array of facts and the contract owner
-  Only contract owner (creator) can
    * Add facts (string fact) -> accessible outside the contract
- Only people who are approved can read the facts
    * getFact(index) – returns specified fact by index [0…count-1]
    * Solidity cannot return all facts at once (array of strings)
    * Approved addresses are hardcoded in the contract
- Everyone can see how many facts there are in the diary
    * count() – returns the count of facts -> not change the state of the contract
- Nobody can delete facts or destroy the contract            

Use modifiers where it is appropriate.
Add appropriate events for the functions.
Test and play around with the contract.

## Problem7. Planet Earth Contract

Create contract that:

-  Declares all continents (Europe, Asia, etc..). Use the best way to declare them – we know that there are fixed amount of continents and we know their names
-  Declares a data representing a single country (name, continent, population)
-  Keep track of each country’s capital, so people can check country’s capital by simply giving a name
-  Store only European countries
-  Have a function to add country (should accept only European countries). The function accepts all countrie’s properties (name, continent, population)
-  Have function to add a capital to a single country (No duplicates – i.e. Sofia cannot be a capital of both Bulgaria and Romania)
-  Have a function that gives the capital by a given country name
-  Have a function to remove a capital
-  Have a function that returns the string representation of each continent (i.e. I receive “Asia”, “Europe”, etc.)
-  Have a function that returns all European countries

## Problem8. Student Info Tracker

In the first Blockchain Secondary School every lecturer should store the students’ information. The information should be public and everyone could see it. 

Write a simple contract in Solidity that keeps track of students’ names, addresses(eth), array of marks and number in class:

-  Only the owner of the contract (lecturer) can create students profile and give marks it does not matter the class/lecture (should be store in appropriate data structure)
    * Hint -> use struct
    * Students profile should be stored in an array -> Students[]
-  Everyone can get the information -> get(index)

Use modifiers where it is appropriate.
Add appropriate events for the functions.
Test and play around with the contract.

## Problem9. Receiving Funds from the default contract function
Create a Deposit contract which:

-  Stores the owner of the contract
-  People can deposit ethers in the contract
-  People can get the balance of the contract
-  Owner can send amount
    * Upon sending, the contract self-destructs with the total amount in the contract

Use modifiers where it is appropriate.
Add appropriate events for the functions.

## Problem10. Inheritance
Write a SafeMath contract (don’t google for the solution!)

-  The contract has methods to safely add, subtract and multiply two numbers
-  The methods should throw if an integer overflow occurs!

Write an Owned contract

-  Which knows its owner
-  Has method to change the owner (called from current owner)
-  Implements an access modifier

Write a contract that inherits SafeMath and Owned and uses their methods

-  The contract should hold one int256 state variable
-  Has a method to change the state variable automatically by these rules:
    * Method is called by the owner
    * The state is incremented by now % 256
    * The state is multiplied by the amount of seconds since the last state change (initially 1)
    * The current block gas limit is subtracted from the state

## Problem11. Simple Bank
Create a simple Bank contract which:

-  holds balances of users
-  holds the owner of the contract
-  function deposit – user deposits ether to the bank
    * method must be payable
    * use require to validate corner cases (e.g. overflow)
    * return the balance of the user
-  function withdraw(amount) – user withdraws ether from the bank
    * use require to validate corner cases
    * use msg.sender.transfer
    * return the new balance of the user
-  unction getBalance – returns the caller's balance

Use modifiers where it is appropriate.
Add appropriate events for the functions.

## Problem12-1. A Simple Timed Auction
Write a  contract for an auction, which continues for 1 minute after the contract is deploye. Use block.timestamp as a start time.

Contract stores:

-  owner of the contract
-  start time
-  duration time
-  stores each buyer's amount bought
-  constructor with a parameter – tokens amount to sell
-  function buyTokens(amount) – check whether the auction has ended

Use modifiers where it is appropriate.
Add appropriate events for the functions.

## Problem12-2.  A Simple Timed Auction (2)
Write a contract for an auction, which continues for 1 block after contract's creation.

## Problem13.  Hunger Games
Every year, in the ruins of what was once North America, the Capitol of the nation of Panem - a technologically advanced, utopian city where the nation's most wealthy and powerful citizens live, forces each of its 12 districts to send a teenage boy and a girl, between the ages of 12 and 18, to compete in the Hunger Games: a nationally televised event in which 'tributes' fight each other within an arena, until one survivor remains.

This time of the year has come and it’s time for the 100th hunger game where you should send the new pair of teenage boy and girl.

Create a Capitol contract which:

-  adds person by age and gender (hint: use struct for storing the person)
-  chooses one girl and one boy:
    * you are not allowed to choose the two people from the same gender
    *  they should be between 12 and 18 years old
    *  they should be chosen by random function (you can use block.timestamp but it is not safe or oraclize -> learn more about it from oraclize documentation)
-  you can check how many girls and boys are added -> returns a positive number
-  after choosing the pair (boy and girl) set the start date of the hunger games and the end date (the hunger games should last 5 minutes)
-  after the end of the hunger game, check if the boy and girl are alive (use random 0 - dead, 1 - alive, use modifier for checking if the hunger game ended)    

Use modifiers where it is appropriate.   
Add appropriate events for the functions.
Test and play around with the contract!


## Problem14.  Pet Adoption

In our adoption sanctuary, we have 5 kinds of animals

-  Fish
-  Cat
-  Dog
-  Rabbit
-  Parrot

The sanctuary will store information for all the people who have adopted a pet.

After creating the contract, we should add the owner of the adoption sanctuary.

Create a contract called PetSanctuary that has:

-  function add (animalKind, howManyPieces) – only the owner can give shelter to animals in the sanctuary
-  function buy (personAge, personGender, animalKind)
    *  save when the animal is bought
    *  you can only adopt one animal for lifetime
    *  Men can only buy dog and fish
    *  Women can buy from every kind, but if they are under 40, they are not allowed to buy a cat
    *  function giveBackAnimal(animalKind)
    *  you can give the animal back in the first 5 minutes after adoption
-  Think about how to store people’s information in the contract.

Use modifiers where it is appropriate.
Add appropriate events for the functions.