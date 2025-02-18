// SPDX-License-Identifier: MIT

//Fund
//withdraw

pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script{
    function fundFundMe(address mostRecentlyDeployed) public {

        uint256  SEND_VALUE = 0.01 ether;
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("the fundme with %s", SEND_VALUE);
    }
    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentlyDeployed);
    }

}

contract WithdrawFundme is Script{

}

