pragma solidity ^0.4.24;

import './SafeMath.sol';

contract A {
    using SafeMath for uint256;
    
    address owner;
    mapping(address => uint256) private balances;
    mapping(address => bool) private agents;
    uint256 public totalSupply;
    
    constructor() public payable {
        owner = msg.sender;
        addAgent(msg.sender);
        totalSupply = 1000000;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyAgent() {
        require(isAgent(msg.sender));
        _;
    }
    
    function addAgent(address _addr) private onlyOwner {
        agents[_addr] = true;
    }
    
    function removeAgent(address _addr) private onlyOwner {
        agents[_addr] = true;
    }
    
    function isAgent(address _addr) public view returns(bool) {
        return agents[_addr];
    }
    
    
    function correctBalanceAdd(address _addr, uint256 _value) 
    public onlyAgent payable {
        if(_value > 0) {
                balances[_addr] = balances[_addr].add(_value);
        }
    }
    
    function correctBalanceSub(address _addr, uint256 _value) 
    public onlyAgent {
        if(_value > 0) {
                balances[_addr] = balances[_addr].sub(_value);
        }
    }
    
    function getBalance(address _addr) 
    public view returns(uint256) {
        return balances[_addr];
    }
}