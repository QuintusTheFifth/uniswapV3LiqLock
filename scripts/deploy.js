// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const {
  Contract,
} = require("hardhat/internal/hardhat-network/stack-traces/model");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const UniswapV3LiqLock = await hre.ethers.getContractFactory(
    "UniswapV3LiqLock"
  );

  const INfManager = new ethers.Contract(
    "0xc36442b4a4522e871399cd717abdd847ab11fe88"
  );
  const uniswapV3LiqLock = await UniswapV3LiqLock.deploy(INfManager);

  await uniswapV3LiqLock.deployed();

  console.log("UniswapV3LiqLock deployed to:", uniswapV3LiqLock.address);

  const TestToken = await hre.ethers.getContractFactory("TestToken");
  const testToken = await TestToken.deploy(
    "TestToken",
    "TEST",
    18,
    1000000000000000000000000,
    uniswapV3LiqLock.address
  );

  await testToken.deployed();

  console.log("TestToken deployed to:", testToken.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
