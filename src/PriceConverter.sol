// SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    
    //address internal constant addresData = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
   /// AggregatorV3Interface internal dataFeed = AggregatorV3Interface(addresData);

  //  constructor() {
   //  dataFeed = 
  //  }
   function getPrice(AggregatorV3Interface dataFeed) internal view returns (uint256) {
        (, int256 price,,,) = dataFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 etherAmount, AggregatorV3Interface addresData ) internal view returns (uint256) {
        uint256 etherPrice = getPrice(addresData);

        return(etherPrice * etherAmount) / 1e18;
    }
  
}
