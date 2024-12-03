// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import{DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMeTest is Test {
    FundMe fundMe ;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        address payable fundMeAddress = payable(deployFundMe.run());
        fundMe = FundMe(fundMeAddress);
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimuimUSD() public {
    
        assertEq(fundMe.MINIMUM_USD(), 5 ether);
    }
    function testOwnerIsMsgSender() public {
        
        assertEq(fundMe._owner(), msg.sender);
    }

    function testFundFailWithoutEnoughETH() public {
        vm.expectRevert(); // hey the next line should revert!
        //assert(this tx fail/reverts)

        fundMe.fund();
    }
    function testUpdatesDataStructure() public {
        vm.prank(USER); //the next Tx will be sent by User
        fundMe.fund{value: 1 ether}();
       // uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(fundMe.getAddressToAmountFunded(USER), 1 ether);

    }

    function testAddsFunder() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunderItem(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
       
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function testWithDrawWithASingleFunder() public funded{
    
    }
}