// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract ProjectFunding {

    struct Project {
        string description;
        uint requiredAmount;
        uint votes;
        uint balance;
    }

    Project[] public projects;

    mapping(uint => mapping(address => bool)) public hasVoted;

    function createProject(string memory description, uint requiredAmount) public {
        projects.push(
            Project(description, requiredAmount, 0, 0)
        );
    }

    function vote(uint projectIndex) public {
        require(
            projectIndex < projects.length,
            "Invalid project"
        );

        require(
            !hasVoted[projectIndex][msg.sender],
            "Already voted"
        );

        projects[projectIndex].votes++;

        hasVoted[projectIndex][msg.sender] = true;
    }

    function fundProject(uint projectIndex) public payable
    {
        require(
            projectIndex < projects.length,
            "Invalid project"
        );

        projects[projectIndex].balance += msg.value;
    }

    function getProject(uint projectIndex) public view returns (Project memory)
    {
        require(
            projectIndex < projects.length,
            "Invalid project"
        );

        return projects[projectIndex];
    }
}