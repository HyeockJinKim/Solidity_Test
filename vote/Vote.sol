pragma solidity 0.4.24;

contract Vote {
    
    // structure
    struct candidator {
        string name;
        uint upVote;
    }
    // variable
    bool isLive;
    address owner;
    candidator[] public candidatorList;
    
    // mapping
    mapping(address => bool) Voted;
    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool isLive);
    event Voting(address owner);
    
    // modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // constructor
    constructor() public {
        owner = msg.sender;
        isLive = true;
        
        emit Voting(owner);
    }
    
    // function
    
    
    function addCandidator(string _name) public onlyOwner {
        require(isLive == true);
        require(candidatorList.length < 5);
        candidatorList.push(candidator(_name, 0));
        
        // emit event
        emit AddCandidator(_name);
    }
    
    function upVote(uint _indexOfCandidator) public {
        require(isLive == true);
        require(Voted[msg.sender] == false);
        require(_indexOfCandidator < candidatorList.length);
        candidatorList[_indexOfCandidator].upVote++;
        
        Voted[msg.sender] = true;
        
        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    
    function finishVoting() public {
        require(isLive == true);

        isLive = false;
        
        emit FinishVote(isLive);
    }
    
}
