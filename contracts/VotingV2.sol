//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Voting{
    
    struct Proposal{
        string title;
        uint upVotes;
        uint downVotes;
        address[] voters;
        bool isActive;
        address proposedBy;
        uint createdAt;
    }
    Proposal proposalS;

    struct Vote{
        bool voted;
        bool agreed;
    }

    uint256 public ProposalCounter;

    mapping (uint256 => Proposal) Proposals;
    mapping (address => mapping(uint256 => Vote)) Voted;

    event ProposalCreated(address from, string title, uint256 createdAt);
    event VotedProposal(address by, uint votedTo, uint votedAt);
    event ProposalDiscarded(uint proposalID, uint discardedAt, address discardedBy);

    modifier proposalExist(uint256 proposalId){
        require(ProposalCounter>0,"No Proposal Found!!!");
        require(proposalId <= ProposalCounter,"No Proposal Found!!!");
        _;
    }

    modifier excludeOwner(uint proposalId){
        Proposal memory proposal = Proposals[proposalId];
        require(proposal.proposedBy != msg.sender,"Owner cannot vote their own proposal");
        _;
    }

    modifier onlyOwner(uint proposalId){
        Proposal memory proposal = Proposals[proposalId];
        require(proposal.proposedBy == msg.sender,"Only Owner can access.");
        _;
    }

    modifier notVoted(uint proposalId){
        Vote memory _vote = Voted[msg.sender][proposalId];
        require(!_vote.voted,"Has already voted");
        _;
    }

    function createProposal(string memory _title) public{
        Proposal memory new_proposal;
        new_proposal.title = _title;
        new_proposal.proposedBy = msg.sender;
        new_proposal.isActive = true;
        new_proposal.createdAt = block.timestamp;
        Proposals[ProposalCounter] = new_proposal;
        ProposalCounter++;
        emit ProposalCreated(new_proposal.proposedBy, new_proposal.title, new_proposal.createdAt);
    }

    function getProposal(uint256 proposalId) public view proposalExist(proposalId) returns(
        uint256 index,
        string memory title,
        address proposedBy,
        uint256 upVotes,
        uint256 downVotes,
        address[] memory voters,
        uint createdAt,
        bool isActive
    )
    {
        Proposal memory required_proposal = Proposals[proposalId];
        return(
            proposalId,
            required_proposal.title,
            required_proposal.proposedBy,
            required_proposal.upVotes,
            required_proposal.downVotes,
            required_proposal.voters,
            required_proposal.createdAt,
            required_proposal.isActive
        );
    }
    
    
    function vote(uint256 proposalId, bool voteType)
        proposalExist(proposalId)
        excludeOwner(proposalId)
        notVoted(proposalId)
    public{
        Proposal storage proposal = Proposals[proposalId];
        require(proposal.isActive,"Cannot vote in inactive proposal");
        if(voteType){
            ++proposal.upVotes;
        }
        else{
            ++proposal.downVotes;
        }
        proposal.voters.push(msg.sender);
        Vote memory voted;
        voted.agreed = voteType;
        voted.voted = true;
        Voted[msg.sender][proposalId] = voted;
        emit VotedProposal(msg.sender,proposalId,block.timestamp);
    }

    function discardProposal(uint proposalId) proposalExist(proposalId) onlyOwner(proposalId) public {
        Proposal memory proposal = Proposals[proposalId];
        require (proposal.isActive,"Proposal already discarded");
        proposal.isActive = false;
        Proposals[proposalId] = proposal;
        emit ProposalDiscarded(proposalId,block.timestamp,msg.sender);
    }

    function getTotalProposal()public view returns(uint256 totalProposal){
        return ProposalCounter;
    }

    function getVote(uint256 proposalID) public view returns(uint256 upVotes,uint256 downVotes){
        Proposal storage proposalVote = Proposals[proposalID];
        return (
            proposalVote.upVotes,
            proposalVote.downVotes
        );
    }
 
}