pragma solidity ^0.4.24;

import './contractA.sol';

contract B {
    A internal token;
    address internal corrector;
    
    constructor(A _token) public payable {
        token = _token;
        corrector = msg.sender;
    }
    
    modifier onlyCorrector() {
        require(msg.sender == corrector);
        _;
    }
    
    function correctBalanceAdd(address _addr, uint256 _value) 
    public onlyCorrector {
        token.correctBalanceAdd(_addr, _value);
    }
    
    function correctBalanceSub(address _addr, uint256 _value) 
    public onlyCorrector {
        token.correctBalanceSub(_addr, _value);
    }
    
    function getToken() public view returns(address) {
        return token;
    }
    
    function getBalance(address _addr) public view returns(uint256) {
        return token.getBalance(_addr);
    } 
    
    function isAgent(address _addr) public view returns(bool) {
        return token.isAgent(_addr);
    }
    
    
}
    