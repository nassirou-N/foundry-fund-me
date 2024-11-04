// SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    
    address internal constant addresData = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
   /// AggregatorV3Interface internal dataFeed = AggregatorV3Interface(addresData);

  //  constructor() {
   //  dataFeed = 
  //  }

    function getConversionRate(uint256 etherAmount) internal view returns (uint256) {
        uint256 etherPrice = getPrice();

        return(etherPrice * etherAmount) / 1e18;
    }

    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface dataFeed = AggregatorV3Interface(addresData);
        (, int256 price,,,) = dataFeed.latestRoundData();

        return uint256(price * 1e10);
    }
}
