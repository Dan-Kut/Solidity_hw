// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract EducationGrant {

    address public owner;

    struct Student {
        address wallet;
        uint balance;
        bool goalCompleted;
        bool paid;
    }

    mapping(address => Student) public students;

    event StudentRegistered(address student);
    event MoneyDeposited(address student, uint amount);
    event GoalCompleted(address student);
    event GrantPaid(address student, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner"
        );
        _;
    }

    function registerStudent(address student) public onlyOwner
    {
        students[student] = Student(
            student,
            0,
            false,
            false
        );

        emit StudentRegistered(student);
    }

    function deposit(address student) public payable
    {
        students[student].balance += msg.value;

        emit MoneyDeposited(student, msg.value);
    }

    function completeGoal(address student) public onlyOwner
    {
        students[student].goalCompleted = true;

        emit GoalCompleted(student);
    }

    function receiveGrant() public {

        Student storage student = students[msg.sender];

        require(
            student.goalCompleted,
            "Goal not completed"
        );

        require(
            !student.paid,
            "Grant already paid"
        );

        uint amount = student.balance;

        student.balance = 0;
        student.paid = true;

        payable(msg.sender).transfer(amount);

        emit GrantPaid(msg.sender, amount);
    }
}