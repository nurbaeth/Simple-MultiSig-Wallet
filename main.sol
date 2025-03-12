// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MultiSigWallet {
    address[] public owners;
    uint public required;
    
    struct Transaction {
        address to;
        uint value;
        bool executed;
        uint approvals;
    }
    
    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public approved;
    
    modifier onlyOwner() {
        require(isOwner(msg.sender), "Not an owner");
        _;
    }
    
    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "Owners required");
        require(_required > 0 && _required <= _owners.length, "Invalid required approvals");
        owners = _owners;
        required = _required;
    }
    
    function isOwner(address _addr) public view returns (bool) {
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == _addr) {
                return true;
            }
        }
        return false;
    }
    
    function submitTransaction(address _to, uint _value) public onlyOwner {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            executed: false,
            approvals: 0
        }));
    }
    
    function approveTransaction(uint _txIndex) public onlyOwner {
        require(_txIndex < transactions.length, "Invalid transaction");
        require(!approved[_txIndex][msg.sender], "Already approved");
        require(!transactions[_txIndex].executed, "Already executed");
        
        approved[_txIndex][msg.sender] = true;
        transactions[_txIndex].approvals++;
        
        if (transactions[_txIndex].approvals >= required) {
            executeTransaction(_txIndex);
        }
    }
    
    function executeTransaction(uint _txIndex) public onlyOwner {
        require(_txIndex < transactions.length, "Invalid transaction");
        require(transactions[_txIndex].approvals >= required, "Not enough approvals");
        require(!transactions[_txIndex].executed, "Already executed");
        
        transactions[_txIndex].executed = true;
        (bool success, ) = transactions[_txIndex].to.call{value: transactions[_txIndex].value}("");
        require(success, "Transaction failed");
    }
    
    receive() external payable {}
}
