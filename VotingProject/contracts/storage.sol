// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Vote {
    //first entity
    struct Voter {
        string name;
        uint256 age;
        uint256 voterId;
        Gender gender;
        uint256 voteCandidateId; //candidate id to whom the voter has voted
        address voterAddress; //EOA of the voter
    }

    //second entity
    struct Candidate {
        string name;
        string party;
        uint256 age;
        Gender gender;
        uint256 candidateId;
        address candidateAddress; //condidate EOA
        uint256 votes; //number of votes
    }

    //third entity
    address electionCommission;

    address public winner;

    uint256 nextVoterId = 1;
    uint256 nextCandidateId = 1;

    //voting period
    uint256 startTime;
    uint256 endTime;
    bool stopVoting;

    mapping(uint256 => Voter) voterDetails;
    mapping(uint256 => Candidate) candidateDetails;

    enum VotingStatus {
        NotStarted,
        InProgress,
        Ended
    }
    enum Gender {
        NotSpecified,
        Male,
        Female,
        Other
    }

    constructor() {
        electionCommission = msg.sender; // msg.sender is a global variable (current call hold address)
    }

    modifier isVotingOver() {
        require(
            block.timestamp <= endTime && stopVoting == false,
            "Voting time is over"
        );
        _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Not authuorized");
        _;
    }

    function registerCandidate(
        string calldata _name,
        string calldata _party,
        uint256 _age,
        Gender _gender
    ) external {
        require(_age >= 18, "You are below 18");
        require(
            isCandidateNotRegistered(msg.sender),
            "You are already registered"
        );
        require(nextCandidateId < 3, "Candidate Registration Full");
        require(
            msg.sender != electionCommission,
            "Election Commision not allowed to register"
        );

        candidateDetails[nextCandidateId] = Candidate({
            name: _name,
            party: _party,
            age: _age,
            gender: _gender,
            candidateId: nextCandidateId,
            candidateAddress: msg.sender,
            votes: 0
        });
        nextCandidateId++;
    }

    function isCandidateNotRegistered(
        address _person
    ) internal view returns (bool) {}

    function getCandidateList() public view returns (Candidate[] memory) {}

    function isVoterNotRegistered(
        address _person
    ) internal view returns (bool) {}

    function registerVoter(
        string calldata _name,
        uint256 _age,
        Gender _gender
    ) external {
        require(_age >= 18, "You are below 18");
        require(isVoterNotRegistered(msg.sender), "You are already registered");

        voterDetails[nextVoterId] = Voter({
            name: _name,
            age: _age,
            voterId: nextVoterId,
            gender: _gender,
            voteCandidateId: 0,
            voterAddress: msg.sender
        });
        nextVoterId++;
    }

    function getVoterList() public view returns (Voter[] memory) {}

    function castVote(uint256 _voterId, uint256 _id) external {}

    function setVotingPeriod(
        uint256 _startTime,
        uint256 _endTime
    ) external onlyCommissioner {}

    function getVotingStatus() public view returns (VotingStatus) {}

    function announceVotingResult() external onlyCommissioner {}

    function emergencyStopVoting() public onlyCommissioner {
        stopVoting = true;
    }
}
