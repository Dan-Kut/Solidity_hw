// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract Grandma {

    address public grandma;

    struct Grandchild {
        address wallet;
        uint birthday;
        bool received;
    }

    Grandchild[] public grandchildren;

    constructor() {
        grandma = msg.sender;
    }

    modifier onlyGrandma() {
        require(msg.sender == grandma, "Only grandma");
        _;
    }

    function addGrandchild(address wallet, uint birthday) public onlyGrandma {
        grandchildren.push(
            Grandchild(wallet, birthday, false)
        );
    }

    receive() external payable {}

    function getGiftAmount() public view returns (uint)
    {
        require(
            grandchildren.length > 0,
            "No grandchildren"
        );

        return address(this).balance / grandchildren.length;
    }

    function takeGift() public {

        uint index = findGrandchild(msg.sender);

        require(
            block.timestamp >= grandchildren[index].birthday,
            "Birthday has not arrived"
        );

        require(
            !grandchildren[index].received,
            "Gift already received"
        );

        uint gift = address(this).balance / grandchildren.length;

        grandchildren[index].received = true;

        payable(msg.sender).transfer(gift);
    }

    function findGrandchild(address wallet) private view returns (uint)
    {
        for (uint i = 0; i < grandchildren.length; i++) {

            if (grandchildren[i].wallet == wallet) {
                return i;
            }
        }

        revert("You are not a grandchild");
    }
}