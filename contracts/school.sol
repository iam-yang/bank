pragma solidity ^0.8.0;

contract School {
    mapping(address => uint) public scoreDic;

    address owner;
    address teacher;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOnwer() {
        require(owner == msg.sender, "not onwer");
        _;
    }

    modifier onlyTeacher() {
        require(teacher == msg.sender, "not setted teacher");
        _;
    }

    function setTeacher(address teacherAddress) public onlyOnwer {
        teacher = teacherAddress;
    }

    function recordScore(address student, uint score) public onlyTeacher {
        require(score <= 100, "score too high");

        scoreDic[student] = score;
    }
}

interface ISchool {
    function recordScore(address student, uint score) external;
}

contract Teacher {
    address owner;
    modifier onlyOnwer() {
        require(owner == msg.sender);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function recordStudentScore(
        address shcoolAddress,
        address student,
        uint score
    ) public {
        ISchool(shcoolAddress).recordScore(student, score);
    }
}
