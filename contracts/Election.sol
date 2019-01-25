pragma solidity ^0.4.22;


contract Election {
  
  //candidate model
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  mapping(uint => Candidate) public candidates;

  uint public candidatesCount;

  mapping(address => bool) public voters;

  event votedEvent (
    uint indexed _candidateId
  );

  constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
  }

  function addCandidate (string _name) private {
    candidatesCount ++;
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  function vote (uint _candidateId) public {
    //require that the account hasn't voted before
    require(!voters[msg.sender]);

    //require that the candidate is valid
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    //record the vote
    voters[msg.sender] = true;

    //update candidate vote count
    candidates[_candidateId].voteCount ++;

    //trigger voted event
    emit votedEvent(_candidateId);
  }
}
