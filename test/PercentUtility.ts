const { ethers } = require("hardhat");


import { expect } from "chai";
import { BigNumber, Contract, ContractFactory, VoidSigner } from "ethers";

/**
* Deploy a Contract
* @param _contractFactory {string}
* @returns Promise<Contract>
*/
async function deployContract(_contractFactory: string, params: any[] = []): Promise<Contract>
{
	try
	{
		const contractFactory: ContractFactory = await ethers.getContractFactory(_contractFactory);

		const deployedContract = await contractFactory.deploy(...params);

		return await deployedContract.deployed();
	}
	catch (error)
	{
		console.error("Error deploying contract:", error);

		throw error;
	}
}



describe("PercentUtility.sol", async () => {
	let percentUtility: Contract;

	let owner: VoidSigner;
	let manager: VoidSigner;


	beforeEach("[beforeEach] Set up contracts..", async () => {
		percentUtility = await deployContract("PercentUtility");
	});


	describe("function percentAmount()", async () => {
		it("Should return percent of the amount..", async () => {
			const TEST_CASES = [
				{
					percent: ethers.utils.parseUnits("1", 4),
					amount: ethers.utils.parseUnits("1", 18),
					expect: ethers.utils.parseUnits("1", 18),
				},
				{
					percent: ethers.utils.parseUnits(".5", 4),
					amount: ethers.utils.parseUnits("1", 18),
					expect: ethers.utils.parseUnits(".5", 18),
				},
				{
					percent: ethers.utils.parseUnits(".25", 4),
					amount: ethers.utils.parseUnits("1", 18),
					expect: ethers.utils.parseUnits(".25", 18),
				},
				{
					percent: ethers.utils.parseUnits("1", 4),
					amount: ethers.utils.parseUnits("10", 18),
					expect: ethers.utils.parseUnits("10", 18),
				},
				{
					percent: ethers.utils.parseUnits(".5", 4),
					amount: ethers.utils.parseUnits("10", 18),
					expect: ethers.utils.parseUnits("5", 18),
				},
				{
					percent: ethers.utils.parseUnits(".9999", 4),
					amount: ethers.utils.parseUnits("10", 18),
					expect: ethers.utils.parseUnits("9.999", 18),
				},
			];

			for (let i = 0; i < TEST_CASES.length; i++)
			{
				const TC = TEST_CASES[i];

				const RESULT = await percentUtility.percentAmount(TC.percent, TC.amount)

				expect(RESULT).to.be.equal(TC.expect);
			}
		});

		it("Should revert if percent is greater than 100%..", async () => {
			// 101% (should fail)
			const highPercent = ethers.utils.parseUnits("1.01", 4);
			const amount = ethers.utils.parseUnits("1", 18);

			await expect(
				percentUtility.percentAmount(highPercent, amount)
			).to.be.revertedWith("_percent > ONE_HUNDRED_PERCENT");
		});

		it("Should handle small amounts and decimals correctly..", async () => {
			const one_percent = ethers.utils.parseUnits(".01", 4); // 1%

			const amount = ethers.utils.parseUnits("0.001", 18);
			const one_percent_of_amount = ethers.utils.parseUnits("0.00001", 18);

			const result_amount = await percentUtility.percentAmount(one_percent, amount);

			expect(result_amount).to.be.equal(one_percent_of_amount);
		});
	});

	describe("function percentOf()", async () => {
		it("Should return the correct percentage of two amounts..", async () => {
			const TEST_CASES = [
				{
					amountA: ethers.utils.parseUnits("5234.23", 18),
					amountB: ethers.utils.parseUnits("10000", 18),
					expectedPercent: ethers.utils.parseUnits(".5234", 4),
				},
				{
					amountA: ethers.utils.parseUnits("1", 18),
					amountB: ethers.utils.parseUnits("1", 18),
					expectedPercent: ethers.utils.parseUnits("1", 4),
				},
				{
					amountA: ethers.utils.parseUnits("500", 18),
					amountB: ethers.utils.parseUnits("10000", 18),
					expectedPercent: ethers.utils.parseUnits(".05", 4),
				},
			];

			for (let i = 0; i < TEST_CASES.length; i++) {
				const TC = TEST_CASES[i];

				let result_percent = await percentUtility.percentOf(TC.amountA, TC.amountB);

				expect(result_percent).to.be.equal(TC.expectedPercent); // 52.34%
			}
		});

		it("Should revert when dividing by zero..", async () => {
			const amountA: BigNumber = ethers.utils.parseUnits("100", 18);
			const amountB: BigNumber = ethers.utils.parseUnits("0", 18);

			await expect(percentUtility.percentOf(amountA, amountB)).to.be.revertedWith("Division by 0");
		});
	});
});
