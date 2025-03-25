# Simple MultiSig Wallet

A secure and decentralized smart contract that requires multiple approvals to execute transactions. Ideal for DAO treasuries, shared wallets, and trustless fund management.

## Features
- 🔑 **Multi-owner support** – Multiple addresses can co-manage funds.
- ✅ **Approval-based execution** – Transactions need a predefined number of confirmations.
- 🔄 **On-chain execution** – Only approved transactions get executed.
- 💰 **Secure fund storage** – Holds ETH securely until consensus is reached. 

## Deployment 
1. Deploy the contract with an array of owner addresses and the required number of approvals.
2. Fund the contract by sending ETH to its address.
 
## Usage 
- **Submit a transaction:** Any owner can propose a transaction.  
- **Approve a transaction:** Owners can approve transactions.  
- **Execute a transaction:** Once enough approvals are collected, the transaction can be executed.

## Smart Contract
### Constructor 
```solidity
constructor(address[] memory _owners, uint _required)
```
- `_owners`: List of wallet owners.
- `_required`: Number of approvals required.

### Functions
```solidity
function submitTransaction(address _to, uint _value) public onlyOwner
```
- Proposes a new transaction.

```solidity
function approveTransaction(uint _txIndex) public onlyOwner
```
- Approves a transaction.

```solidity
function executeTransaction(uint _txIndex) public onlyOwner
```
- Executes a transaction if approvals meet the threshold.

## Security Considerations
- Only owners can approve transactions.
- Funds can only be moved once approvals meet the required threshold.
- Uses Solidity 0.8.19 to prevent overflow attacks.

🚀 **Built for security, transparency, and trustless collaboration!**

