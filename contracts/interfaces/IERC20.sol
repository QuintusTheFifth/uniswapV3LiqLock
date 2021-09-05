pragma solidity ^0.8.0;

interface IERC20{
    event Transfer (address toTheMinter, uint mintedTokens, bool supplied);
    function mint(address accountAddress,  uint amount) external ;
    function balanceOf(address accountAddress) external view returns(uint);
    function transfer(address _to, uint _amount) external returns(bool);
}