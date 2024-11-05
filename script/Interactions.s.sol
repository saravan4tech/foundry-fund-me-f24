// Fund
// Withdraw


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "./DeployFundme.s.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

        function run() external {
         
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

    }

    function fundFundMe(address mostRecentlyDeployed) public payable{
       
        vm.prank(msg.sender);
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }


}

contract WithdrawFundMe is Script{
    

     function run() external {
         
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

    }

    function withdrawFundMe(address mostRecentlyDeployed) public{
       vm.prank(msg.sender);
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        console.log("Withdrew funds");
    }
    
}
