// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    AggregatorV3Interface internal dataFeed;
    address public addresData = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

    constructor() {
        dataFeed = AggregatorV3Interface(addresData);
    }

    function getConversionRate(uint256 etherAmount) internal view returns (uint256) {
        uin256 etherPrice = getPrice();

        retun(etherPrice * etherAmount) / 1e18;
    }

    function getPrice() internal view returns (uint256) {
        (, int256 price,,,) = dataFeed.latestRoundData();

        return uint256(price * 1e10);
    }
}
