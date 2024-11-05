//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {

    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {

        // FundFundMe fundFundMe = new FundFundMe();
        // fundFundMe.fundFundMe(address(fundMe));

        // vm.prank(USER);
        // fundMe.fund{value: SEND_VALUE}();

        // WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        // withdrawFundMe.withdrawFundMe(address(fundMe));

        //Fund Arrange
        FundFundMe fundFundMe = new FundFundMe();
        //Fund Act
        vm.prank(USER);
        fundFundMe.fundFundMe(address(fundMe)); //fund
        //Fund Assert
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER); //check USER is registered as a funder

        //Withdraw Arrange
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        //Withdraw Act
        vm.prank(msg.sender);
        withdrawFundMe.withdrawFundMe(address(fundMe)); //withdraw
        assert(address(fundMe).balance == 0);


    }
}