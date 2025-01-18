import { Contract, ContractFactory } from "ethers";
import { writeFileSync } from "fs";
import { run, network } from "hardhat";

require("dotenv").config();

const { ethers } = require("hardhat");
const path = require("path");


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


const filePath = path.join(__dirname, "..", "deployed.txt");
const delay = (ms: number) => new Promise(res => setTimeout(res, ms));


async function main()
{
	console.log("Attempting Deployment..");

	switch (network.name)
	{
		case "sepolia":
			break;
		case "base-sepolia":
			break;
		default:
			console.error("Error: Unknown network");
			process.exit(999);
	}

	const [DEPLOYER] = await ethers.getSigners();

	writeFileSync(filePath, `Attempted Deployment Timestamp: ${Date.now()}\n`, { flag: "a" });

	const notice: string = `Network: ${network.name}\nAccount: ${DEPLOYER.address}\nBalance: ${await DEPLOYER.getBalance()}\n`;

	writeFileSync(filePath, notice, { flag: "a" });

	console.log(notice);


	const arrayUtility = await deployContract("ArrayUtility");

	writeFileSync(filePath, `arrayUtility: ${arrayUtility.address}\n`, { flag: "a" });

	console.log("arrayUtility contract address:", arrayUtility.address);


	// Delay
	console.log("Waiting 30 seconds before verifying..");
	await delay(30000);


	// verify
	try
	{
		await run(
			"verify:verify",
			{
				address: arrayUtility.address,
				constructorArguments: [],
				contract: "contracts/ArrayUtility.sol:ArrayUtility"
			}
		);
	}
	catch (e: any)
	{
		if (e.message.toLowerCase().includes("already verified"))
		{
			console.log("Already verified!");
		}
		else
		{
			console.error(e);
		}
	}

	const notice_balance_after: string = `Account Balance After: ${await DEPLOYER.getBalance()}\n`;

	writeFileSync(filePath, notice_balance_after, { flag: "a" });

	writeFileSync(
		filePath,
		`================================================================================\n\n`,
		{ flag: "a" }
	);

	console.log(notice_balance_after);
}


main().then(() => {
	process.exit(0);
}).catch((error) => {
	console.error(error);
	process.exit(1);
});
