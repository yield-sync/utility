// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { AddressArrayUtility } from "../AddressArrayUtility.sol";


/**
* @notice WARNING: This contract is ONLY for TESTING.
* @notice This is a wrapper contract made only for testing. Do not set this is the Array Utility.
*/
contract TestAddressArrayUtility is
	AddressArrayUtility
{
	bool public isUniqueResult;

	function value_exists(address _value)
		public
		view
		returns (bool exists_)
	{
		return _value_exists[_value];
	}

	function uniqueAddresses()
		public
		view
		returns (address[] memory)
	{
		return _uniqueAddresses;
	}

	function isUniqueWrapper(address[] memory _array)
		public
	{
		isUniqueResult = isUnique(_array);
	}
}
