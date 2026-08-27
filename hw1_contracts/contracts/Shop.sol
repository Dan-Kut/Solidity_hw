// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

contract Shop {

    struct Product {
        string name;
        uint price;
    }

    Product[] public products;

    function addProduct(string memory name, uint price) public {
        products.push(Product(name, price));
    }

    function buyProduct(uint index) public payable {
        require(index < products.length, "Invalid product");

        require(msg.value >= products[index].price, "Not enough ETH");
    }

    function getProducts() public view returns (Product[] memory)
    {
        return products;
    }
}