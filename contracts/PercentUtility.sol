// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { IPercentUtility } from "./interface/IPercentUtility.sol";


contract PercentUtility is
	IPercentUtility
{
	uint256 public constant override DIVISOR = 10_000;
	uint256 public constant override ONE_HUNDRED_PERCENT = 10_000;


	/// @inheritdoc IPercentUtility
	function percentAmount(uint256 _percent, uint256 _a)
		public
		pure
		override
		returns (uint256)
	{
		return (_a * _percent) / DIVISOR;
	}

	/// @inheritdoc IPercentUtility
	function percentOf(uint256 _a, uint256 _b)
		public
		pure
		override
		returns (uint256)
	{
		require(_b > 0, "Division by 0");

		uint256 result = (_a * ONE_HUNDRED_PERCENT) / _b;

		return uint256(result);
	}
}
