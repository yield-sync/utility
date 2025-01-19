const { ethers } = require("hardhat");


import { expect } from "chai";
import { Contract, ContractFactory, VoidSigner } from "ethers";

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


describe("[0.0] ArrayUtility.sol", async () => {
	let arrayUtility: Contract;

	let owner: VoidSigner;
	let manager: VoidSigner;


	beforeEach("[beforeEach] Set up contracts..", async () => {
		arrayUtility = await deployContract("TestArrayUtility");
	});


	describe("function contains()", async () => {
		it("Should return true if array does contains value..", async () => {
			[owner] = await ethers.getSigners();

			expect(await arrayUtility.contains([owner.address], owner.address)).to.be.true;
		});

		it("Should return false if array does NOT contains value..", async () => {
			[owner, manager] = await ethers.getSigners();

			expect(await arrayUtility.contains([owner.address], manager.address)).to.be.false;
		});
	});

	describe("function difference()", async () => {
		it("Should return the difference of two arrays..", async () => {
			const result = await arrayUtility.difference([owner.address, manager.address], [manager.address]);

			expect(result.length).to.be.equal(1);
			expect(result[0]).to.be.equal(owner.address);
		});

		it("Should return an empty array if no difference exists..", async () => {
			const result = await arrayUtility.difference([owner.address], [owner.address]);

			expect(result.length).to.be.equal(0);
		});
	});

	describe("function indexOf()", async () => {
		it("Should return the index of an element in an array..", async () => {
			const result = await arrayUtility.indexOf([owner.address, manager.address], owner.address);

			expect(result).to.be.equal(0);
		});

		it("Should return -1 if the element does not exist in the array..", async () => {
			const result = await arrayUtility.indexOf([owner.address], manager.address);

			expect(result).to.be.equal(-1);
		});
	});

	describe("function intersect()", async () => {
		it("Should return common elements in two arrays..", async () => {
			const result = await arrayUtility.intersect([owner.address, manager.address], [manager.address]);

			expect(result.length).to.be.equal(1);
			expect(result[0]).to.be.equal(manager.address);
		});

		it("Should return an empty array if no common elements exist..", async () => {
			const result = await arrayUtility.intersect([owner.address], [manager.address]);

			expect(result.length).to.be.equal(0);
		});
	});

	describe("function isSorted()", async () => {
		it("Should return true if the array is sorted..", async () => {
			const result = await arrayUtility.isSorted([ethers.constants.AddressZero, manager.address, owner.address]);

			expect(result).to.be.equal(true);
		});

		it("Should return false if the array is not sorted..", async () => {
			const result = await arrayUtility.isSorted([owner.address, ethers.constants.AddressZero, manager.address]);

			expect(result).to.be.equal(false);
		});
	});

	describe("function reverse()", async () => {
		it("Should return the reversed array..", async () => {
			const result = await arrayUtility.reverse(
				[owner.address, manager.address]
			);

			expect(result[0]).to.be.equal(manager.address);
			expect(result[1]).to.be.equal(owner.address);
		});
	});

	describe("function sort()", async () => {
		it(
			"Should sort an unordered array..",
			async () => {
				[owner, manager] = await ethers.getSigners();

				const OWNER_IN_BASE_10 = parseInt(owner.address, 16)
				const MANAGER_IN_BASE_10 = parseInt(manager.address, 16)

				// Simple
				let result = await arrayUtility.sort(
					[owner.address, owner.address, ethers.constants.AddressZero]
				);

				expect(result[0]).to.be.equal(ethers.constants.AddressZero);
				expect(result[1]).to.be.equal(owner.address);
				expect(result[2]).to.be.equal(owner.address);

				// With multiple addresses
				let result2 = await arrayUtility.sort(
					[manager.address, owner.address, ethers.constants.AddressZero]
				);

				expect(result2[0]).to.be.equal(ethers.constants.AddressZero);

				if (OWNER_IN_BASE_10 > MANAGER_IN_BASE_10)
				{
					expect(result2[1]).to.be.equal(manager.address);
					expect(result2[2]).to.be.equal(owner.address);
				}
				else
				{
					expect(result2[1]).to.be.equal(owner.address);
					expect(result2[2]).to.be.equal(manager.address);
				}
			}
		);
	});

	describe("function subArray()", async () => {
		it("Should return a subarray between the specified indices..", async () => {
			const result = await arrayUtility.subArray(
				[ethers.constants.AddressZero, owner.address, manager.address],
				1,
				3
			);

			expect(result.length).to.be.equal(2);
			expect(result[0]).to.be.equal(owner.address);
			expect(result[1]).to.be.equal(manager.address);
		});

		it("Should revert if the indices are invalid..", async () => {
			await expect(
				arrayUtility.subArray([ethers.constants.AddressZero, owner.address, manager.address], 2, 1)
			).to.be.revertedWith("Invalid indices");
		});
	});

	describe("function union()", async () => {
		it("Should return the union of two arrays, removing duplicates..", async () => {
			const result = await arrayUtility.union(
				[owner.address, manager.address],
				[manager.address, ethers.constants.AddressZero]
			);

			expect(result.length).to.be.equal(3);
			expect(result).to.include.members([
				owner.address,
				manager.address,
				ethers.constants.AddressZero,
			]);
		});

		it("Should handle arrays with no duplicates correctly..", async () => {
			const result = await arrayUtility.union(
				[owner.address],
				[manager.address]
			);

			expect(result.length).to.be.equal(2);
			expect(result).to.include.members([owner.address, manager.address]);
		});
	});

	describe("function containsDuplicates()", async () => {
		it(
			"Should return true if duplicates are in array..",
			async () => {
				await arrayUtility.containsDuplicates([owner.address, owner.address]);

				expect(await arrayUtility.duplicateFound()).to.be.equal(true);
			}
		);

		it(
			"Should return false if duplicates NOT in array..",
			async () => {
				await arrayUtility.containsDuplicates([owner.address, manager.address]);

				expect(await arrayUtility.duplicateFound()).to.be.equal(false);
			}
		);

		it(
			"Should clear seen mapping after utilizing..",
			async () => {
				await arrayUtility.containsDuplicates([owner.address, manager.address]);

				expect(await arrayUtility.duplicateFound()).to.be.equal(false);

				expect(await arrayUtility.value_exists(owner.address)).to.be.equal(false);

				expect(await arrayUtility.value_exists(manager.address)).to.be.equal(false);
			}
		);

	});

	describe("function removeDuplicates()", async () => {
		it(
			"Should remove duplicates from an array..",
			async () => {
				await arrayUtility.removeDuplicates([owner.address, owner.address]);

				let result = await arrayUtility.uniqueAddresses();

				expect(result.length).to.be.equal(1);
				expect(result[0]).to.be.equal(owner.address);
			}
		);
	});
});
