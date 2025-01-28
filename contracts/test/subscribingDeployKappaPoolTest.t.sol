// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {subscriptionManagementActions} from "../src/subscriptionManagementActions.sol";
import {subscriptionAPIquoter} from "../src/subscriptionAPIquoter.sol";

contract subscribingDeployKappaPoolTest is Test {
    struct ChainEndpoints {
        uint256 origin;
        uint256 reactive;
    }

    ChainEndpoints public endpoints;

    //---CONTRACTS TO BE TESTED-----------------
    //------ORIGIN CHAIN----------
    subscriptionManagementActions public actions;

    //-------REACTIVE CHAIN---------------
    subscriptionAPIquoter public apiQuoter;

    function setUp() public {
        apiQuoter = new subscriptionAPIquoter();
        endpoints.reactive = vm.createSelectFork(vm.rpcUrl("reactive"));
        actions = new subscriptionManagementActions(address(apiQuoter));
        endpoints.origin = vm.createSelectFork(vm.rpcUrl("sepolia"));
    }

    // Add your test functions here
}
