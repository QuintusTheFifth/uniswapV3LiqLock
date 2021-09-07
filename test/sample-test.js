const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("lock and mint", function () {
  it("Should lock and mint ERC20", async function () {

    accounts = await web3.eth.getAccounts();

    const MockNfManager = await ethers.getContractFactory("MockedNFManager");
    const mockNfManager = await MockNfManager.deploy();
    await mockNfManager.deployed();

    const UniV3 = await ethers.getContractFactory("UniswapV3LiqLock");
    const uniV3 = await UniV3.deploy(mockNfManager);
    await uniV3.deployed();

    const Token = await ethers.getContractFactory("TestToken");
    const token = await Token.deploy();
    await token.deployed();

    await mockNfManager.mintV3s();

    await uniV3.lockNFTandMint(1,token.address);

    expect(await token.balanceOf(accounts[0]).to.equal(10000));
  });
});
