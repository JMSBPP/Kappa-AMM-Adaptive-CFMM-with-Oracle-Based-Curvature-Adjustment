// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementState} from "./subscriptionManagementState.sol";

contract subscriptionManagementPermissionedActions is
    subscriptionManagementState
{
    /**
     * @notice Sets the subscriber status if the
     * uniswap pair address is valid
     * @param uniswapPairAddress address of the pool to subscribe
     * @param liquidityProviderAddress address of the liquidity provider s
     * @param value boolean
     */

    //security:
    //
    //protocol:
    //
    //gas:
    // is this the mmost gas optimal way to do this?
    function setSubscriber(
        address uniswapPairAddress,
        address liquidityProviderAddress,
        bool value
    ) public onlyUniswapV2Pair(uniswapPairAddress) {
        subscribers[uniswapPairAddress][liquidityProviderAddress] = value;
    }
    /**
     * @notice Adds a subscriber. This function is
     * only trigger triggered by a
     * checkSubscribePostconditions(
     *      UniswapPairAddress,
     *      liquidityProviderAddress) exit event
     *
     * @param uniswapPairAddress address of the pair
     */
    function addSubscriber(
        address uniswapPairAddress
    ) internal onlyUniswapV2Pair(uniswapPairAddress) {
        subscribersCount[uniswapPairAddress] += 1;
    }
}
