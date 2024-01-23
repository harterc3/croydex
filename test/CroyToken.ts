import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("CroyToken", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    const name: string = "CroyToken";
    const symbol: string = "CROY";
    const tokenTotal: BigInt = BigInt("2100000000000000000");
    const tokenDecimals: Number = 8;
    // Contracts are deployed using the first signer/account by default
    const [owner, account2, account3] = await ethers.getSigners();

    const CroyToken = await ethers.getContractFactory("CroyToken");
    const croytoken = await CroyToken.deploy(name, symbol, tokenTotal, tokenDecimals);

    return { croytoken, name, symbol, tokenTotal, tokenDecimals, owner, account2, account3 };
  }

  describe("Deployment", function () {
    it("Should set the right name, symbol, tokenTotal, and tokenDecimals", async function () {
      const { croytoken, name, symbol, tokenTotal, tokenDecimals, owner } = await loadFixture(deployFixture);

      expect(await croytoken.name()).to.equal(name);
      expect(await croytoken.symbol()).to.equal(symbol);
      expect(await croytoken.totalSupply()).to.equal(tokenTotal);
      expect(await croytoken.decimals()).to.equal(tokenDecimals);
    });
  });
});
