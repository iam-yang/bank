pragma solidity ^0.8.0;

contract ArraySplice {
    function removeAtIndex(
        uint[] memory arr,
        uint index
    ) public pure returns (uint[] memory) {
        require(index < arr.length, "Index out of bounds");

        uint[] memory newArr = new uint[](arr.length - 1);
        for (uint i = 0; i < newArr.length; i++) {
            if (i < index) {
                newArr[i] = arr[i];
            } else {
                newArr[i] = arr[i + 1];
            }
        }

        return newArr;
    }
}
