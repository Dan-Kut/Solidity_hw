// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract EmergencyFund {

    address public owner;

    mapping(address => bool) public participants;

    uint public approvals;

    address public beneficiary;

    bool public emergency;

    mapping(address => bool) public approved;

    event ParticipantAdded(address participant);
    event MoneyDeposited(address participant, uint amount);
    event EmergencyRequested(address beneficiary);
    event EmergencyApproved(address participant);
    event MoneyPaid(address beneficiary, uint amount);

    constructor() {
        owner = msg.sender;
        participants[msg.sender] = true;
    }

    modifier onlyParticipant() {
        require(
            participants[msg.sender],
            "Not a participant"
        );
        _;
    }

    function addParticipant(address participant) public
    {
        require(
            msg.sender == owner,
            "Only owner"
        );

        participants[participant] = true;

        emit ParticipantAdded(participant);
    }

    function deposit() public payable onlyParticipant
    {
        emit MoneyDeposited(
            msg.sender,
            msg.value
        );
    }

    function requestEmergency() public onlyParticipant
    {
        beneficiary = msg.sender;
        emergency = true;
        approvals = 0;

        emit EmergencyRequested(msg.sender);
    }

    function approveEmergency() public onlyParticipant
    {
        require(emergency, "No emergency");
        require(!approved[msg.sender], "Already approved");

        approved[msg.sender] = true;
        approvals++;

        emit EmergencyApproved(msg.sender);
    }

    function receiveHelp() public
    {
        require(
            msg.sender == beneficiary,
            "Not beneficiary"
        );

        require(
            approvals >= 2,
            "Need 2 approvals"
        );

        uint amount = address(this).balance;

        emergency = false;

        payable(msg.sender).transfer(amount);

        emit MoneyPaid(msg.sender, amount);
    }

    receive() external payable {}
}