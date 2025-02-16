// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";

import { IPercentUtility } from "./interface/IPercentUtility.sol";


contract PercentUtility is
	IPercentUtility
{
	using SafeMath for uint256;


	/// @inheritdoc IPercentUtility
	uint256 public constant override PERCENT_ONE_HUNDRED = 10_000;


	/// @inheritdoc IPercentUtility
	function percentAmount(uint256 _percent, uint256 _a)
		public
		pure
		override
		returns (uint256)
	{
		return _a.mul(_percent).div(PERCENT_ONE_HUNDRED);
	}

	/// @inheritdoc IPercentUtility
	function percentOf(uint256 _a, uint256 _b)
		public
		pure
		override
		returns (uint256)
	{
		return _a.mul(PERCENT_ONE_HUNDRED).div(_b, "_b == 0");
	}
}
