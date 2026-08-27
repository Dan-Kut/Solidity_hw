// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract TodoList {
    string[] private tasks;

    function addTask(string memory task) public {
        tasks.push(task);
    }

    function deleteTask(uint index) public {
        require(index < tasks.length, "Invalid index");

        for (uint i = index; i < tasks.length - 1; i++) {
            tasks[i] = tasks[i + 1];
        }

        tasks.pop();
    }

    function getTasks() public view returns (string[] memory) {
        return tasks;
    }
}