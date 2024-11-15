// SPDX-License-Identifier: MIT
pragma solidity <0.8.28;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    event votedEvent(uint indexed _candidateId);

    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;
    mapping(address => bool) public voters;

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "User already voted");
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate ID"
        );
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        emit votedEvent(_candidateId);
    }
}
