// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IPercentUtility
{
	/**
	* @dev [view-uint256]
	* @notice One Hundred Percent
	* @return {uint256}
	*/
	function PERCENT_ONE_HUNDRED()
		external
		view
		returns (uint256)
	;


	/**
	* @notice Percent Amount of `_a`
	* @param _percent {uint256}
	* @param _a {uint256}
	* @return {uint256}
	*/
	function percentAmount(uint256 _percent, uint256 _a)
		external
		pure
		returns (uint256)
	;

	/**
	* @notice `_a` percent of `_b`
	* @param _a {uint256}
	* @param _b {uint256}
	* @return {uint256}
	*/
	function percentOf(uint256 _a, uint256 _b)
		external
		pure
		returns (uint256)
	;
}
