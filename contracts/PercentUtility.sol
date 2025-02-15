// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { IPercentUtility } from "./interface/IPercentUtility.sol";


contract PercentUtility is
	IPercentUtility
{
	uint16 public constant override ONE_HUNDRED_PERCENT = 10_000;
	uint16 public constant override DIVISOR = 10_000;


	/// @inheritdoc IPercentUtility
	function percentAmount(uint16 _percent, uint256 _a)
		public
		pure
		override
		returns (uint256)
	{
		require(_percent <= ONE_HUNDRED_PERCENT, "_percent > ONE_HUNDRED_PERCENT");

		unchecked
		{
			return (_a * _percent) / DIVISOR;
		}
	}

	/// @inheritdoc IPercentUtility
	function percentOf(uint256 _a, uint256 _b)
		public
		pure
		override
		returns (uint16)
	{
		require(_b > 0, "Division by 0");

		uint256 result = (_a * ONE_HUNDRED_PERCENT) / _b;

		require(result <= type(uint16).max, "result >= type(uint16).max");

		return uint16(result);
	}
}
