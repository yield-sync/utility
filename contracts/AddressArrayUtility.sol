// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { IAddressArrayUtility } from "./interface/IAddressArrayUtility.sol";


contract AddressArrayUtility is
	IAddressArrayUtility
{
	address[] internal _uniqueAddresses;

	bool public override duplicateFound;

	mapping(address _element => bool exists) internal _value_exists;


	constructor ()
	{
		duplicateFound = false;
	}


	function _quickSort(address[] memory _array, uint256 _left, uint256 _right)
		internal
		pure
	{
		uint256 i = _left;
		uint256 j = _right;

		if(i == j)
		{
			return;
		}

		address pivot = _array[uint256(_left + (_right - _left) / 2)];

		while (i <= j)
		{
			while (_array[uint256(i)] < pivot)
			{
				i++;

				if (i > _right)
				{
					break;
				}
			}

			while (pivot < _array[uint256(j)])
			{
				if (j == _left)
				{
					break;
				}

				j--;
			}

			if (i <= j)
			{
				(_array[uint256(i)], _array[uint256(j)]) = (_array[uint256(j)], _array[uint256(i)]);
				i++;

				if (i > _right)
				{
					break;
				}

				if (j == _left)
				{
					break;
				}

				j--;
			}
		}

		if (_left < j)
		{
			_quickSort(_array, _left, j);
		}

		if (i < _right)
		{
			_quickSort(_array, i, _right);
		}
	}


	/// @inheritdoc IAddressArrayUtility
	function contains(address[] memory _array, address _element)
		public
		pure
		override
		returns (bool)
	{
		for (uint256 i = 0; i < _array.length; i++)
		{
			if (_array[i] == _element)
			{
				return true;
			}
		}

		return false;
	}

	/// @inheritdoc IAddressArrayUtility
	function difference(address[] memory _array1, address[] memory _array2)
		public
		pure
		override
		returns (address[] memory)
	{
		address[] memory result = new address[](_array1.length);

		uint256 count = 0;

		for (uint256 i = 0; i < _array1.length; i++)
		{
			bool found = false;

			for (uint256 j = 0; j < _array2.length; j++)
			{
				if (_array1[i] == _array2[j])
				{
					found = true;
					break;
				}
			}
			if (!found)
			{
				result[count++] = _array1[i];
			}
		}

		address[] memory finalResult = new address[](count);

		for (uint256 i = 0; i < count; i++)
		{
			finalResult[i] = result[i];
		}

		return finalResult;
	}

	/// @inheritdoc IAddressArrayUtility
	function indexOf(address[] memory _array, address _element)
		public
		pure
		override
		returns (int256)
	{
		for (uint256 i = 0; i < _array.length; i++)
		{
			if (_array[i] == _element)
			{
				return int256(i);
			}
		}

		return -1;
	}

	/// @inheritdoc IAddressArrayUtility
	function intersect(address[] memory _array1, address[] memory _array2)
		public
		pure
		override
		returns (address[] memory)
	{
		uint256 resultSize = _array1.length < _array2.length ? _array1.length : _array2.length;

		address[] memory result = new address[](resultSize);

		uint256 count = 0;

		for (uint256 i = 0; i < _array1.length; i++)
		{
			for (uint256 j = 0; j < _array2.length; j++)
			{
				if (_array1[i] == _array2[j])
				{
					result[count++] = _array1[i];

					break;
				}
			}
		}

		address[] memory finalResult = new address[](count);

		for (uint256 i = 0; i < count; i++)
		{
			finalResult[i] = result[i];
		}

		return finalResult;
	}

	/// @inheritdoc IAddressArrayUtility
	function isSorted(address[] memory _array)
		public
		pure
		override
		returns (bool)
	{
		for (uint256 i = 1; i < _array.length; i++)
		{
			if (_array[i - 1] > _array[i])
			{
				return false;
			}
		}

		return true;
	}

	/// @inheritdoc IAddressArrayUtility
	function reverse(address[] memory _array)
		public
		pure
		override
		returns (address[] memory)
	{
		address[] memory reversed = new address[](_array.length);

		for (uint256 i = 0; i < _array.length; i++)
		{
			reversed[_array.length - i - 1] = _array[i];
		}

		return reversed;
	}

	/// @inheritdoc IAddressArrayUtility
	function sort(address[] memory _array)
		public
		pure
		override
		returns (address[] memory)
	{
		_quickSort(_array, 0, uint256(_array.length - 1));

		return _array;
	}

	/// @inheritdoc IAddressArrayUtility
	function subArray(address[] memory _array, uint256 start, uint256 end)
		public
		pure
		override
		returns (address[] memory)
	{
		require(start < end && end <= _array.length, "Invalid indices");

		address[] memory result = new address[](end - start);

		for (uint256 i = start; i < end; i++)
		{
			result[i - start] = _array[i];
		}

		return result;
	}

	/// @inheritdoc IAddressArrayUtility
	function union(address[] memory _array1, address[] memory _array2)
		public
		pure
		override
		returns (address[] memory)
	{
		uint256 totalSize = _array1.length + _array2.length;

		address[] memory tempArray = new address[](totalSize);

		uint256 count = 0;

		for (uint256 i = 0; i < _array1.length; i++)
		{
			tempArray[count++] = _array1[i];
		}

		for (uint256 i = 0; i < _array2.length; i++)
		{
			bool found = false;

			for (uint256 j = 0; j < _array1.length; j++)
			{
				if (_array2[i] == _array1[j])
				{
					found = true;

					break;
				}
			}

			if (!found)
			{
				tempArray[count++] = _array2[i];
			}
		}

		address[] memory result = new address[](count);

		for (uint256 i = 0; i < count; i++)
		{
			result[i] = tempArray[i];
		}

		return result;
	}


	/// @notice mutative


	/// @inheritdoc IAddressArrayUtility
	function containsDuplicates(address[] memory _array)
		public
		override
		returns (bool)
	{
		duplicateFound = false;

		for (uint256 i = 0; i < _array.length; i++)
		{
			if (!_value_exists[_array[i]])
			{
				_value_exists[_array[i]] = true;
			}
			else
			{
				duplicateFound = true;

				break;
			}
		}

		for (uint256 i = 0; i < _array.length; i++)
		{
			_value_exists[_array[i]] = false;
		}

		return duplicateFound;
	}

	/// @inheritdoc IAddressArrayUtility
	function removeDuplicates(address[] memory _array)
		public
		override
		returns (address[] memory)
	{
		delete _uniqueAddresses;

		for (uint256 i = 0; i < _array.length; i++)
		{
			if (!_value_exists[_array[i]])
			{
				_value_exists[_array[i]] = true;

				_uniqueAddresses.push(_array[i]);
			}
		}

		for (uint256 i = 0; i < _uniqueAddresses.length; i++)
		{
			_value_exists[_uniqueAddresses[i]] = false;
		}

		return _uniqueAddresses;
	}
}
