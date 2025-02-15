// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { IPercentUtility } from "./interface/IPercentUtility.sol";


contract PercentUtility is
	IPercentUtility
{
	uint16 public constant ONE_HUNDRED_PERCENT = 1e4;
	uint16 public constant DIVISOR = 1e4;


	/// @inheritdoc IPercentUtility
	function getPercentAmount(uint16 percent, uint256 x)
		public
		pure
		override
		returns (uint256)
	{
		require(percent <= ONE_HUNDRED_PERCENT, "percent > ONE_HUNDRED_PERCENT");

		unchecked
		{
			return (x * percent) / DIVISOR;
		}
	}
}
