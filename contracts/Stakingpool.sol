// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;



import  "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingReward is Ownable(msg.sender){

    address public immutable Stakingtoken;
    address public immutable RewardsToken;
   
 struct User{
uint256 balance;
uint256 timeStaked;
 }

 mapping(address=>User) users;
//our rate is ten% per year, but i decided to make it per hour.
uint256 rate=11;

constructor(address x, address y) {
    Stakingtoken = x;
    RewardsToken = y;
    }

function stake(uint256 _amount) public {
    require(IERC20(Stakingtoken).transferFrom(msg.sender,address(this),_amount));
    User storage u=users[msg.sender];
    u.balance+=_amount;
    u.timeStaked=block.timestamp;
}


function checkRewards(address _user) public view returns(uint256 reward){
 reward = calculateRewards(_user);
}
    


function calculateRewards(address _staker) internal view returns(uint256){
require(users[_staker].balance>0,'No tokens staked');
uint256 duration=block.timestamp-users[_staker].timeStaked;
uint256 durationInHours=duration/3600;
uint256 pendingReward= 11*durationInHours * users[_staker].balance;
pendingReward/=10000;

return pendingReward;
}

function withdrawAll() public{
   require(users[msg.sender].balance>0,'No tokens staked');
   uint256 reward=calculateRewards(msg.sender);
//send reward
require(IERC20(RewardsToken).transfer(msg.sender,reward));
//send pricipal
require(IERC20(Stakingtoken).transfer(msg.sender,users[msg.sender].balance));

users[msg.sender].balance=0;
users[msg.sender].timeStaked=0;
}
}




