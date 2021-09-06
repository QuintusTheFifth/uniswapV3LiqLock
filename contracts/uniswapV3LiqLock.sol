//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma abicoder v2;

import "hardhat/console.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/INonFungiblePositionManager.sol";

contract UniswapV3LiqLock {
    mapping(uint256 => address) public idToAddress;

    INonfungiblePositionManager private NF_MANAGER;

    constructor() {
        NF_MANAGER = INonfungiblePositionManager(
            0xC36442b4a4522E871399CD717aBDD847Ab11FE88
        );
    }

    function lockNFTandMint(uint256 tokenId, address mintAddress) external {
        (address operator, uint256 liquidity) = getPositionInfo(tokenId);

        require(operator == msg.sender, "not the operator");
        require(liquidity > 0, "no liquidity");

        NF_MANAGER.transferFrom(msg.sender, address(this), tokenId);

        idToAddress[tokenId] = msg.sender;

        mint(mintAddress, liquidity);
    }

    function getPositionInfo(uint256 tokenId)
        internal
        view
        returns (address, uint256)
    {
        (, address operator, , , , , , uint256 liquidity, , , , ) = NF_MANAGER
            .positions(tokenId);

        return (operator, liquidity);
    }

    function mint(address _tokenAddress, uint256 amount)
        internal
        returns (bool)
    {
        IERC20(_tokenAddress).mint(msg.sender, amount);
        return true;
    }
}
