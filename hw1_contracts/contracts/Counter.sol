// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract Counter {

    uint private value;

    function increase() public {
        value++;
    }

    function decrease() public {
        require(value > 0, "Counter cannot be negative");
        value--;
    }

    function getCounter() public view returns (uint) {
        return value;
    }
}