// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {IUniswapV2Pair} from "@UniswapV2/interfaces/IUniswapV2Pair.sol";
import {IUniswapV2Factory} from "@UniswapV2/interfaces/IUniswapV2Factory.sol";
import {subscriptionManagementState} from "./subscriptionManagementState.sol";
import {subscriptionManagementInvariants} from "./subscriptionManagementInvariants.sol";
import {ISubscriptionManagementErrors} from "./interfaces/ISubscriptionManagementErrors.sol";
import {ISubscriptionManagementEvents} from "./interfaces/ISubscriptionManagementEvents.sol";

contract subscriptionManagementGuards is
    subscriptionManagementState,
    subscriptionManagementInvariants,
    ISubscriptionManagementErrors,
    ISubscriptionManagementEvents
{
    modifier onlyUniswapV2Pair(address _uniswapPairAddress) {
        if (!isUniswapV2Pair(_uniswapPairAddress)) {
            revert NotValidUniswapV2Pair();
        }
        _;
    }

    modifier onlyNotSubscribed(
        address _uniswapPairAddress,
        address liquidityProviderAddress
    ) {
        if (subscribers[liquidityProviderAddress][_uniswapPairAddress].state) {
            revert AlreadySubscribed();
        }
        _;
    }

    modifier onlySubscribed(
        address _uniswapPairAddress,
        address liquidityProviderAddress
    ) {
        if (
            !subscribers[liquidityProviderAddress][liquidityProviderAddress]
                .state
        ) {
            revert NotSubscribed();
        }
        _;
    }

    modifier PoolDeploymentLock(address _uniswapPairAddress) {
        if (!(subscribersCount[_uniswapPairAddress] == 0)) {
            revert PoolDeploymentLocked();
        }
        _;
    }

    modifier hasValidVolumeRouter() {
        if (getVolumeRouter() == address(0)) {
            revert InvalidVolumeRouter();
            _;
        }
    }

    modifier setToIddlePermission(address liquidityProviderAddress) {
        if (
            !(subscriptionState[liquidityProviderAddress] ==
                SubscriptionState.SUBSCRIBED ||
                subscriptionState[liquidityProviderAddress] ==
                SubscriptionState.FAILED)
        ) {
            revert NotAbletoSetToIdle();
        }
        _;
    }

    modifier receivingSubscribers(address liquidityProviderAddress) {
        if (
            subscriptionState[liquidityProviderAddress] !=
            SubscriptionState.IDLE
        ) {
            revert UnableToReceiveSubscribers();
        }
        _;
    }

    /**
     * @notice This function checks if the given address is a Uniswap V2 pair.
     * THIS FUNCTION ENABLES US TO USE THE
     * subscribers[UniswapPairAddress][liquidityProviderAddress]
     * MAPPING
     * @param uniswapPairAddress The address of the Uniswap pair to check.
     * @return bool True if the address is a valid Uniswap V2 pair, false otherwise.
     */
    // security:
    // How an attacker would attack this function,
    // What incentives would he has to do so?
    //protocol:
    //
    // gas:
    //  is this gas efficient?
    function isUniswapV2Pair(
        address uniswapPairAddress
    ) internal view returns (bool) {
        address token0 = IUniswapV2Pair(uniswapPairAddress).token0();
        address token1 = IUniswapV2Pair(uniswapPairAddress).token1();
        address factory = IUniswapV2Pair(uniswapPairAddress).factory();

        return
            IUniswapV2Factory(factory).getPair(token0, token1) ==
            uniswapPairAddress;
    }
}
