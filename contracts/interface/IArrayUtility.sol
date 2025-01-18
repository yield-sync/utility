// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IArrayUtility
{
	/**
	* @return {bool}
	*/
	function duplicateFound()
		external
		view
		returns (bool)
	;


	/// @notice pure


	/**
	* @notice Sort `_array`
	* @param _array {address[]}
	* @return {address[]}
	*/
	function sort(address[] memory _array)
		external
		pure
		returns (address[] memory)
	;


	/// @notice mutative


	/**
	* @notice Check if `_array` contains duplicates
	* @param _array {address[]}
	* @return duplicateFound_ {bool}
	*/
	function containsDuplicates(address[] memory _array)
		external
		returns (bool duplicateFound_)
	;

	/**
	* @notice Remove duplicates from `_array`
	* @param _array {address[]}
	* @return {address[]}
	*/
	function removeDuplicates(address[] memory _array)
		external
		returns (address[] memory)
	;
}
