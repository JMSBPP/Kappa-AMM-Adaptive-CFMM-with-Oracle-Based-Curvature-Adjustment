// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementGuards} from "./subscriptionManagementGuards.sol";
import {ReentrancyGuard} from "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
contract subscriptionManagementPermissionedActions is
    subscriptionManagementGuards,
    ReentrancyGuard
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
    ) internal nonReentrant {
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
    function addSubscriber(address uniswapPairAddress) internal nonReentrant {
        subscribersCount[uniswapPairAddress] += 1;
    }

    function deployKappaOptimalPool(
        address _uniswapPairAddress
    )
        internal
        PoolDeploymentLock(_uniswapPairAddress)
        nonReentrant
        returns (address _kappaPairAddress)
    {
        //LOW LEVEL DEPLOYMENT
        _kappaPairAddress = address(0);
    }
}
