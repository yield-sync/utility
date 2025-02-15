// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { IPercentUtility } from "./interface/IPercentUtility.sol";


contract PercentUtility is
	IPercentUtility
{
	/// @inheritdoc IPercentUtility
	uint16 public constant override ONE_HUNDRED_PERCENT = 1e4;
	/// @inheritdoc IPercentUtility
	uint16 public constant override DIVISOR = 1e4;


	/// @inheritdoc IPercentUtility
	function getPercentAmount(uint16 _percent, uint256 _x)
		public
		pure
		override
		returns (uint256)
	{
		require(_percent <= ONE_HUNDRED_PERCENT, "_percent > ONE_HUNDRED_PERCENT");

		unchecked
		{
			return (_x * _percent) / DIVISOR;
		}
	}
}
