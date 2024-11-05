// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// import fil
import {Script, console} from "forge-std/Script.sol";
import "../src/FundMe.sol";

contract DeployFundMe is Script {

    function run() external {
        vm.startBroadcast();
        new FundMe();
        vm.stopBroadcast();
    }
}