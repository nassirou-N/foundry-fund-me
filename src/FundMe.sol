// SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//custom error
error AddressNotValid();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable _owner;
    AggregatorV3Interface s_priceFeed;

    constructor(address priceFeed) {
        _owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        require(msg.sender == address(0), AddressNotValid());
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "didn't send enought ETH");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Not be Owner");
        _;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool transfertOk,) = payable(msg.sender).call{value: address(this).balance}("");
        require(transfertOk, "faild to withdraw all money");
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
