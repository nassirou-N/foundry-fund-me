// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// import fil
import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    function run() external returns(address) {
        HelperConfig helperconfig = new HelperConfig();
        address etheUsdPriceFeed = helperconfig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe fundme = new FundMe(etheUsdPriceFeed);
        vm.stopBroadcast();
        return address(fundme);
    }
}
