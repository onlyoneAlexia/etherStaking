// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenB is ERC20('TokenB','TKB'){

function mint(address to) public {
    _mint(to,10000e18);
}

}