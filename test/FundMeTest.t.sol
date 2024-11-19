// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import{DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMeTest is Test {
    FundMe fundMe ;
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        address payable fundMeAddress = payable(deployFundMe.run());
        fundMe = FundMe(fundMeAddress);
    }

    function testMinimuimUSD() public {
    
        assertEq(fundMe.MINIMUM_USD(), 5 ether);
    }
    function testOwnerIsMsgSender() public {
        
        assertEq(fundMe._owner(), address(this));
    }
}