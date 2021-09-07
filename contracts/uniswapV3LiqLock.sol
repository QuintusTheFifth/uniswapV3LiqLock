//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma abicoder v2;

import "hardhat/console.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/INonFungiblePositionManager.sol";

contract UniswapV3LiqLock {
    mapping(uint256 => address) public idToAddress;

    INonfungiblePositionManager private NF_MANAGER;
    // INonfungiblePositionManager(
    //         0xC36442b4a4522E871399CD717aBDD847Ab11FE88
    //     );

    constructor(INonfungiblePositionManager _nfManager) {
        NF_MANAGER = _nfManager;
    }

    function lockNFTandMint(uint256 tokenId, address mintAddress) external {
        uint256 liquidity= getLiquidity(tokenId);

        require(NF_MANAGER.ownerOf(tokenId) == msg.sender, "not the owner");
        require(liquidity > 0, "no liquidity");

        NF_MANAGER.transferFrom(msg.sender, address(this), tokenId);

        idToAddress[tokenId] = msg.sender;

        mint(mintAddress, liquidity);
    }

    function getLiquidity(uint256 tokenId)
        internal
        view
        returns (uint256)
    {
        (, , , , , , , uint256 liquidity, , , , ) = NF_MANAGER
            .positions(tokenId);

        return liquidity;
    }

    function mint(address _tokenAddress, uint256 amount)
        internal
        returns (bool)
    {
        IERC20(_tokenAddress).mint(msg.sender, amount);
        return true;
    }
}
