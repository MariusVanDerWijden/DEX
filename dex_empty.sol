
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {

    IERC20 public token;

    constructor (address addr) {
        // TODO implement me
    }

    function TokenBalance() internal view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function EthBalance() internal view returns (uint256) {
        return address(this).balance;
    }

    function getUnits(uint256 inputTokens, uint256 inputReserves, uint256 outputReserves) internal pure returns (uint256) {
        require(inputReserves > 0 && outputReserves > 0, "not enough funds");

        uint256 inputWithFee = inputTokens * 999;
        uint256 numerator = inputWithFee * outputReserves;
        uint256 denominator = (inputWithFee * 1000) + inputTokens;

        return numerator / denominator; // (x*y)/(z+x)
    }
    
    function swapTokenToETH(uint256 tokens) public {
        // TODO implement me
    }

    function swapETHToToken() public payable {
        // TODO implement me
    }


    function addLiquidity(uint256 tokens) public payable {
        // TODO implement me
    }
}
