// SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//custom error
error AddressNotValid();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;

    address[] public s_funders;
    mapping(address funder => uint256 amountFunded) public s_addressToAmountFunded;

    address public immutable _owner;
    AggregatorV3Interface s_priceFeed;

    constructor(address priceFeed) {
        _owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
       // require(msg.sender == address(0), AddressNotValid());
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "didn't send enought ETH");
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Not be Owner");
        _;
    }

    function cheaperwithdraw() public onlyOwner{
        uint256 fundersLength = s_funders.length;
        for(uint256 funderIndex = 0; funderIndex < fundersLength; funderIndex++){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);

        (bool transfertOk,) = payable(msg.sender).call{value: address(this).balance}("");
        require(transfertOk, "faild to withdraw all money");
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < s_funders.length; funderIndex++) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }

        s_funders = new address[](0);

        (bool transfertOk,) = payable(msg.sender).call{value: address(this).balance}("");
        require(transfertOk, "faild to withdraw all money");
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    /**
     * view / pure function (Getter)
     */
    function getAddressToAmountFunded(address _fundingAddress) external view returns(uint256) {
        return s_addressToAmountFunded[_fundingAddress];
    }

    function getFunderItem(uint256 _index) external view returns(address){
        return s_funders[_index];
    }
}
