// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IAddressArrayUtility
{
	/// @notice pure


	/**
	* @notice Determine if `_array` contains `_element`
	* @param _array {address[]}
	* @param _element {uint256}
	*/
	function contains(address[] memory _array, address _element)
		external
		pure
		returns (bool)
	;

	/**
	* @notice Compute difference between `_arrayA` and `_arrayB`
	* @param _arrayA {address[]}
	* @param _arrayB {address[]}
	*/
	function difference(address[] memory _arrayA, address[] memory _arrayB)
		external
		pure
		returns (address[] memory)
	;

	/**
	* @notice Get index of `_element` within `_array`
	* @param _array {address[]}
	* @param _element {uint256}
	*/
	function indexOf(address[] memory _array, address _element)
		external
		pure
		returns (int256)
	;

	/**
	* @notice Compute shared elements of `_arrayA` and `_arrayB`
	* @param _arrayA {address[]}
	* @param _arrayB {address[]}
	*/
	function intersect(address[] memory _arrayA, address[] memory _arrayB)
		external
		pure
		returns (address[] memory)
	;

	/**
	* @notice Determine if `_array` is sorted
	* @param _array {address[]}
	*/
	function isSorted(address[] memory _array)
		external
		pure
		returns (bool)
	;

	/**
	* @notice Reverse `_array`
	* @param _array {address[]}
	*/
	function reverse(address[] memory _array)
		external
		pure
		returns (address[] memory)
	;

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

	/**
	* @notice Get subArray of `_array` with given indexes `_start` and `_end`
	* @param _array {address[]}
	* @param _start {uint256}
	* @param _end {uint256}
	*/
	function subArray(address[] memory _array, uint256 _start, uint256 _end)
		external
		pure
		returns (address[] memory)
	;

	/**
	* @notice Compute the union of `_arrayA` and `_arrayB`
	* @param _arrayA {address[]}
	* @param _arrayB {address[]}
	*/
	function union(address[] memory _arrayA, address[] memory _arrayB)
		external
		pure
		returns (address[] memory)
	;


	/// @notice mutative


	/**
	* @notice Determine if `_array` is unique
	* @param _array {address[]}
	* @return duplicateFound_ {bool}
	*/
	function isUnique(address[] memory _array)
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
