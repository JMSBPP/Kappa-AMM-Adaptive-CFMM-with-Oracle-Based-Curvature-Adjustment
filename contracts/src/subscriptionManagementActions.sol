// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementPermissionedActions} from "./subscriptionManagementPermissionedActions.sol";

contract subscriptionManagementActions is
    subscriptionManagementPermissionedActions
{
    function requestSubscribe(
        address uniswapPairAddress,
        address liquidityProviderAddress
    )
        public
        onlyNotSubscribed(uniswapPairAddress, liquidityProviderAddress)
        onlyUniswapV2Pair(uniswapPairAddress)
    {
        subscriptionState = SubscriptionState.SUBSCRIBING;
        // rest of the pre-conditions

        //...
        //...

        addSubscriber(uniswapPairAddress);
        setSubscriber(uniswapPairAddress, liquidityProviderAddress, true);
    }
}
