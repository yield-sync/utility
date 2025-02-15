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
	 * @notice Percent Amount of `_a`
	 * @param _percent {uint16}
	 * @param _a {uint256}
	 */
	function percentAmount(uint16 _percent, uint256 _a)
		external
		pure
		returns (uint256)
	;

	/**
	 * @notice `_a` percent of `_b`
	 * @param _a {uint256}
	 * @param _b {uint256}
	 */
	function percentOf(uint256 _a, uint256 _b)
		external
		pure
		returns (uint16)
	;
}
