// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementPermissionedActions} from "./subscriptionManagementPermissionedActions.sol";

contract subscriptionManagementActions is
    subscriptionManagementPermissionedActions
{
    function subscribe(
        address uniswapPairAddress,
        address liquidityProviderAddress
    )
        public
        onlyNotSubscribed(uniswapPairAddress, liquidityProviderAddress)
        onlyUniswapV2Pair(uniswapPairAddress)
    {
        subscriptionState = SubscriptionState.SUBSCRIBING;
        setSubscriber(uniswapPairAddress, liquidityProviderAddress, true);
        addSubscriber(uniswapPairAddress);
        emit Subscribed(liquidityProviderAddress, uniswapPairAddress);
        subscriptionState = SubscriptionState.SUBSCRIBED;
    }
}
