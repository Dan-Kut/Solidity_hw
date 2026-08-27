// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;


// ArrayLibrary


library ArrayLibrary {

    function find(uint[] memory array, uint number) public pure returns (uint) {

        for (uint i = 0; i < array.length; i++) {
            if (array[i] == number) {
                return i;
            }
        }

        revert("Number not found");
    }

    function sort(uint[] memory array) public pure returns (uint[] memory) {

        uint[] memory newArray = new uint[](array.length);

        for (uint i = 0; i < array.length; i++) {
            newArray[i] = array[i];
        }

        for (uint i = 0; i < newArray.length; i++) {
            for (uint j = i + 1; j < newArray.length; j++) {

                if (newArray[i] > newArray[j]) {
                    uint temp = newArray[i];
                    newArray[i] = newArray[j];
                    newArray[j] = temp;
                }
            }
        }

        return newArray;
    }

    function remove(uint[] memory array, uint index) public pure returns (uint[] memory) {

        require(index < array.length, "Invalid index");

        uint[] memory newArray = new uint[](array.length - 1);

        for (uint i = 0; i < index; i++) {
            newArray[i] = array[i];
        }

        for (uint i = index; i < array.length - 1; i++) {
            newArray[i] = array[i + 1];
        }

        return newArray;
    }
}



// ArrayUtils



contract ArrayUtils {

    using ArrayLibrary for uint[];

    uint[] public numbers;

    constructor() {
        numbers.push(5);
        numbers.push(2);
        numbers.push(8);
        numbers.push(1);
    }

    function findNumber(uint number)public view returns (uint)
    {
        return numbers.find(number);
    }

    function sortNumbers() public returns (uint[] memory)
    {
        numbers = numbers.sort();
        
        return numbers;
    }

    function removeNumber(uint index) public returns (uint[] memory)
    {
        numbers = numbers.remove(index);

        return numbers;
    }
}