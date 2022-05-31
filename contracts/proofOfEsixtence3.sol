pragma solidity ^0.8.0;

contract ProofofExistence3{

    mapping( bytes32 => bool) private proofs;
    

    function storeProof(bytes32 proof) internal{
        proofs[proof] = true;
    }

    function notarize(string memory document)public{
        bytes32 proof;
        proof = proofFor(document);
        storeProof(proof);
    }

    function proofFor(string memory document) pure private returns(bytes32){
        return sha256(abi.encodePacked(document));
    }

    function checkDocument(string memory document)public view returns(bool){
        bytes32 proof = proofFor(document);
        return hasProof(proof);
    }

    function hasProof(bytes32 proof)internal view returns(bool){
        return proofs[proof];
    }

}