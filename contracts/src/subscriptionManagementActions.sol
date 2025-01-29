// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementPermissionedActions} from "./subscriptionManagementPermissionedActions.sol";
import {subscriptionManagementAPI} from "./subscriptionManagementAPI.sol";
contract subscriptionManagementActions is
    subscriptionManagementPermissionedActions
{
    function requestSubscribe(
        address uniswapPairAddress,
        address liquidityProviderAddress
    )
        public
        payable
        onlyNotSubscribed(uniswapPairAddress, liquidityProviderAddress)
        onlyUniswapV2Pair(uniswapPairAddress)
        receivingSubscribers(liquidityProviderAddress)
    {
        //TODO: check if get reactive cost is cross-chain call
        //from destination chain to the reacctive chain?
        //-----How to go around this?---
        //-1 We need to ask the liquidity provider for a
        //subscription timeframe he/she would like o have his portafolio
        //managed
        //--2- Based on that time, the protocol estimates how much
        //would it cost to listen all pair events for that timeframe
        //---2.1 This analysis is a time series analysis that
        // provides an average cost considering current market
        //conticions and forecasts
        //3. Protocol also provides an APY based on the inventories
        // the liquidity provider will provide
        //4. Protocol provides a quaote with APY vs cost for liquidtiy
        //provider to asses wheter is a good deal or not

        subscriptionState[liquidityProviderAddress] = SubscriptionState
            .SUBSCRIBING;

        //...
        //...

        addSubscriber(uniswapPairAddress);
        setSubscriber(uniswapPairAddress, liquidityProviderAddress, true);
    }
}
