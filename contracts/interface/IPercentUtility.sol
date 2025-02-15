// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IPercentUtility
{
	/**
	 * @notice Get Percent
	 * @param percent {uint16}
	 * @param x {uint256}
	 */
	function getPercentAmount(uint16 percent, uint256 x)
		external
		pure
		returns (uint256)
	;
}
