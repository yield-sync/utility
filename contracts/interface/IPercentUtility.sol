// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IPercentUtility
{
	/**
	* @dev [view-uint16]
	* @notice One Hundred Percent
	* @return {uint16}
	*/
	function ONE_HUNDRED_PERCENT()
		external
		view
		returns (uint16)
	;

	/**
	* @dev [view-uint16]
	* @notice One Hundred Percent
	* @return {uint16}
	*/
	function DIVISOR()
		external
		view
		returns (uint16)
	;


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
