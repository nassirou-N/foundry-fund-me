// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";


contract FundMeTest is Test {
     FundMe fundMe ;
    function setUp() external {
       fundMe = new FundMe();
    }

    function testMinimuimUSD() public {
    
        assertEq(fundMe.MINIMUM_USD(), 5 ether);
    }
    function testOwnerIsMsgSender() public {
        
        assertEq(fundMe._owner(), address(this));
    }
}