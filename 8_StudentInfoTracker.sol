pragma solidity ^0.5.11;

contract StudentInfoTracker {

    struct Student {
        string name;
        address ethereumAddress;
        uint256 mark;
        uint256 number;
    }
    
    Student[] public students;
    uint public studentId = 1;
    address contractOwner = msg.sender;
    
    event LogCreated(uint indexed number, string name, address ethereumAddress, uint256 mark);
    event LogUpdated(uint indexed number, string name, address ethereumAddress, uint256 mark);
    
    modifier ownerOnly() {
        require(msg.sender == contractOwner, "The caller needs to be contract owner");
        _;
    }
    
    function read(uint256 _number) view public returns(string memory, address, uint256, uint256) {
        uint256 i = find(_number);
        return(students[i].name, students[i].ethereumAddress, students[i].mark, students[i].number);
    }
    
    function create(string memory _name, address _ethereumAddress, uint256 _mark) public ownerOnly {
        students.push(Student(_name, _ethereumAddress, _mark, studentId));
        emit LogCreated(studentId, _name, _ethereumAddress, _mark);
        studentId++;
    }
    
    function update(uint256 _number, string memory _name, address _ethereumAddress, uint256 _mark) public ownerOnly {
        uint256 i = find(_number);
        students[i].name = _name;
        students[i].ethereumAddress = _ethereumAddress;
        students[i].mark = _mark;
        emit LogUpdated(_number, _name, _ethereumAddress, _mark);
     }
    
    function find(uint256 _number) view internal returns(uint) {
        for(uint i = 0; i < students.length; i++) {
            if(students[i].number == _number) {
                 return i;
            }
         }
        revert('User does not exist!');
    }
    
}