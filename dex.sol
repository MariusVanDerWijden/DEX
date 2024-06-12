
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {

    IERC20 public token;

    constructor (address addr) {
        token = IERC20(addr);
    }

    function TokenBalance() internal view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function EthBalance() internal view returns (uint256) {
        return address(this).balance;
    }

    function getPrice(uint256 fromTokens, uint256 maxFrom, uint256 maxTo) internal pure returns (uint256) {
        require(maxFrom > 0 && maxTo > 0, "not enough funds");

        uint256 numerator = fromTokens * maxTo;
        uint256 denominator = (maxFrom * 100) + fromTokens;

        return numerator / denominator;
    }

    function swapTokenToETH(uint256 tokens) public {
        uint256 price = getPrice(tokens, TokenBalance(), EthBalance());
        token.transferFrom(msg.sender, address(this), tokens);
        payable(msg.sender).transfer(price);
    }

    function swapETHToToken() public payable {
        uint256 price = getPrice(msg.value, EthBalance()-msg.value, TokenBalance());
        token.transfer(msg.sender, price);
    }


    function addLiquidity(uint256 tokens) public payable {
        uint256 ethBalance = EthBalance() - msg.value;
        uint256 tokenBalance = TokenBalance();

        if (tokenBalance == 0) {
            token.transferFrom(msg.sender, address(this), tokens);
            return;
        }

        uint256 price = getPrice(msg.value, ethBalance, tokenBalance);
        require(tokens >= price, "not enough tokens send");

        token.transferFrom(msg.sender, address(this), price);
    }
}