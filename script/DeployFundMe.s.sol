// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// import fil
import {Script, console} from "forge-std/Script.sol";
import "../src/FundMe.sol";

contract DeployFundMe is Script {
    function run() external returns (address) {
        vm.startBroadcast();
        FundME fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        return fundme;
    }
}
