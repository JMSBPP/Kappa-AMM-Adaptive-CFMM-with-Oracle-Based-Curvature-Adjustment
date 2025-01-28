// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementPermissionedActions} from "./subscriptionManagementPermissionedActions.sol";
import {subscriptionAPIquoter} from "./subscriptionAPIquoter.sol";
contract subscriptionManagementActions is
    subscriptionManagementPermissionedActions
{
    constructor(address _API) subscriptionManagementPermissionedActions(_API) {}

    function requestSubscribe(
        address uniswapPairAddress,
        address liquidityProviderAddress
    )
        public
        payable
        onlyNotSubscribed(uniswapPairAddress, liquidityProviderAddress)
        onlyUniswapV2Pair(uniswapPairAddress)
    {
        subscriptionState[liquidityProviderAddress] = SubscriptionState
            .SUBSCRIBING;
        // rest of the pre-conditions
        //1.verify

        //...
        //...

        addSubscriber(uniswapPairAddress);
        setSubscriber(uniswapPairAddress, liquidityProviderAddress, true);
    }
}
