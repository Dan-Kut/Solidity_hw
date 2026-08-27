// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract Subscription {

    address public admin;

    uint public price;
    uint public duration;

    mapping(address => uint) public subscriptionEnd;

    constructor(uint _price, uint _duration) {
        admin = msg.sender;
        price = _price;
        duration = _duration;
    }

    function subscribe() public payable {
        require(msg.value >= price, "Not enough ETH");

        subscriptionEnd[msg.sender] = block.timestamp + duration;
    }

    function isSubscribed(address user) public view returns (bool)
    {
        return block.timestamp < subscriptionEnd[user];
    }

    function changePrice(uint newPrice) public {
        require(msg.sender == admin, "Only admin");

        price = newPrice;
    }
}