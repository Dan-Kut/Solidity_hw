// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract Voting {

    struct Candidate {
        string name;
        uint votes;
    }

    Candidate[] public candidates;

    function addCandidate(string memory name) public {
        candidates.push(Candidate(name, 0));
    }

    function vote(uint index) public {
        require(index < candidates.length, "Invalid candidate");

        candidates[index].votes++;
    }

    function getResults() public view returns (Candidate[] memory)
    {
        return candidates;
    }
}