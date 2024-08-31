
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import  "@openzeppelin/contracts/access/Ownable.sol";

contract EtherStaker  is Ownable(msg.sender){
 struct User{
uint256 balance;
uint256 timeStaked;
 }


mapping(address=>User) etherBalances;

uint256 rate=11;

function depositEther() public payable {
 User storage u=etherBalances[msg.sender];
    u.balance+=msg.value;
    u.timeStaked=block.timestamp;


}

function checkRewards(address _user) public view returns(uint256 reward){
 reward = calculateRewards(_user);
}

function calculateRewards(address _staker) internal view returns(uint256){
require(etherBalances[_staker].balance>0,'No tokens staked');
uint256 duration=block.timestamp-etherBalances[_staker].timeStaked;
uint256 durationInHours=duration/3600;
uint256 pendingReward= 11*durationInHours * etherBalances[_staker].balance;
pendingReward/=10000;

return pendingReward;
}

function withdrawAll() public{
   require(etherBalances[msg.sender].balance>0,'No Ether staked');
   uint256 reward=calculateRewards(msg.sender);
reward+=etherBalances[msg.sender].balance;

 (bool success,)=  payable(msg.sender).call{value: reward}('');
require (success);
etherBalances[msg.sender].balance=0;
etherBalances[msg.sender].timeStaked=0;
}
}