//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./interfaces/IERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";

contract UniswapV3LiqLock {
    mapping(uint256 => address) public idToAddress;

    address public owner;
    INonfungiblePositionManager public constant NF_MANAGER =
        INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);

    constructor() {
        owner = msg.sender;
    }

    function lockNFTandMint(uint256 tokenId, address mintAddress) external {
        (, address operator, , , , , , uint256 liquidity, , , , ) = NF_MANAGER
            .positions(tokenId);
        
        require(operator == msg.sender, "not the operator");
        require(liquidity > 0, "no liquidity");

        NF_MANAGER.safeTransferFrom(msg.sender, address(this), tokenId);

        idToAddress[tokenId] = msg.sender;

        mint(mintAddress, liquidity);
    }

    function mint(address _tokenAddress, uint256 amount)
        internal
        returns (bool)
    {
        IERC20(_tokenAddress).mint(msg.sender, amount);
        return true;
    }
}
