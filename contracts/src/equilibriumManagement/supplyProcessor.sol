// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementGuards} from "../subscriptionManagement/subscriptionManagementGuards.sol";
contract supplyProcessor is subscriptionManagementGuards {
    //TODO:
    //1. We need to have a resgitry of all the subscriptions
    //this is doene inhertinh the subscritptionManagementState
    //which has the subscribers registry mapping
    //2. this mapping needs to output the address of the unisapV2Pair

    event optimalAllocationSent();

    // @dev: It sends the optimal portion of the inventories of the liquidity
    // provider to the corresponding UniswapV2Pair.
    function depositOptimalAllocation() public {
        emit optimalAllocationSent();
    }
}
