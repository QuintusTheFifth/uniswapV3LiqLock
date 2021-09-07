pragma solidity >=0.8.0;
pragma abicoder v2;

import "../interfaces/INonFungiblePositionManager.sol";

contract MockedNFManager is INonfungiblePositionManager {
    mapping(address => MintParams) addressToNft;
    mapping(uint256 => address) tokenToAddress;

    struct MintParams {
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        address recipient;
        uint256 deadline;
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {}

    function ownerOf(uint256 tokenId)
        public
        virtual
        override
        returns (address)
    {
        return tokenToAddress[tokenId];
    }

    function positions(uint256 tokenId)
        external
        pure
        override
        returns (
            uint96 nonce,
            address operator,
            address token0,
            address token1,
            uint24 fee,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        )
    {
        return (
            0,
            0x0000000000000000000000000000000000000000,
            0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            0x6B175474E89094C44Da98b954EedeAC495271d0F,
            10000,
            -55200,
            -3300,
            10000,
            1524262770897610582174726249748564034,
            2170934432583806932310334999141776,
            0,
            0
        );
    }

    function mintV3s() public {
        MintParams memory nft = MintParams(
            0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            0x6B175474E89094C44Da98b954EedeAC495271d0F,
            3000,
            -44400,
            -44100,
            300,
            300,
            52,
            60,
            0x0000000000000000000000000000000000000000,
            555
        );
        addressToNft[msg.sender] = nft;
        tokenToAddress[1] = msg.sender;
    }
}
