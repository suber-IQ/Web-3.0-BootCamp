// SPDX-License-Identifier: MIT


pragma solidity ^0.8.26;




contract Vote {

   //first entity
    struct Voter {
        string name;
        uint age;
        uint voterId;
        Gender gender;
        uint voteCandidateId; //candidate id to whom the voter has voted
        address voterAddress; //EOA of the voter
    }

    //second entity
    struct Candidate {
        string name;
        string party;
        uint age;
        Gender gender;
        uint candidateId;
        address candidateAddress; //condidate EOA
        uint votes; //number of votes
    }


   //third entity
    address electionCommission;

    address public winner;

    uint nextVoterId = 1;
    uint nextCandidateId = 1;

    //voting period
    uint startTime;
    uint endTime;
    bool stopVoting;


    mapping(uint => Voter) voterDetails;
    mapping(uint => Candidate) candidateDetails;


    enum VotingStatus {NotStarted, InProgress, Ended}
    enum Gender {NotSpecified, Male, Female, Other}


    constructor() {
        electionCommission = msg.sender; // msg.sender is a global variable (current call hold address)
        
    }


    modifier isVotingOver() {
        require(block.timestamp <=endTime && stopVoting==false,"Voting time is over");
      _;
    }


    modifier onlyCommissioner() {
        require(msg.sender==electionCommission,"Not authuorized");
        _;
    }


    function registerCandidate(
        string calldata _name,
        string calldata _party,
        uint _age,
        Gender _gender
    ) external {
       
    }


    function isCandidateNotRegistered(address _person) internal view returns (bool) {
           
    }


    function getCandidateList() public view returns (Candidate[] memory) {
     
    }


    function isVoterNotRegistered(address _person) internal view returns (bool) {
         
    }


    function registerVoter(
        string calldata _name,
        uint _age,
        Gender _gender
    ) external {




    }


    function getVoterList() public view returns (Voter[] memory) {
   
    }


    function castVote(uint _voterId, uint _id) external {
   
    }


    function setVotingPeriod(uint _startTime, uint _endTime) external onlyCommissioner() {
   
    }


    function getVotingStatus() public view returns (VotingStatus) {
   
    }


    function announceVotingResult() external onlyCommissioner() {
   
    }


    function emergencyStopVoting() public onlyCommissioner() {
       stopVoting=true;
    }
}











