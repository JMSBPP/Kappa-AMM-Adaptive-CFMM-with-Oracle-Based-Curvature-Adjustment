// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {subscriptionManagementActions} from "../src/subscriptionManagement/subscriptionManagementActions.sol";
import {subscriptionManagementOffchain} from "../src/subscriptionManagement/subscriptionManagementOffchain.sol";

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
    subscriptionManagementOffchain public offChain;

    function setUp() public {
        offChain = new subscriptionManagementOffchain();
        endpoints.reactive = vm.createSelectFork(vm.rpcUrl("reactive"));
        actions = new subscriptionManagementActions();
        endpoints.origin = vm.createSelectFork(vm.rpcUrl("reactive"));
    }

    // Add your test functions here

    //VERIFY THE DEFAULT STATE FOR ANY ASPIRING SUBSCRIBER IS IDLE
    //VERIFY THE UNISWAP PAIR ADDRESS ARE CORRECTLY CAPTURED
    //VERIFY THAT IT CHECKS IF IT IS ALREADY SUBSCRIBED
}
