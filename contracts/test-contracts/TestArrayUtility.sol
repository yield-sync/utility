// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { ArrayUtility } from "../ArrayUtility.sol";


/**
* @notice WARNING: This contract is ONLY for TESTING.
* @notice This is a wrapper contract made only for testing. Do not set this is the Array Utility.
*/
contract TestArrayUtility is
	ArrayUtility
{
	function uniqueAddresses()
		public
		view
		returns (address[] memory)
	{
		return _uniqueAddresses;
	}
}
