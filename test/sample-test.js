const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("mint and return tokenId", function () {
  it("Should mint and return tokenId", async function () {
    const UniV3 = await ethers.getContractFactory("UniswapV3LiqLock");
    const uniV3 = await UniV3.deploy();
    await uniV3.deployed();

    // expect(await greeter.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
