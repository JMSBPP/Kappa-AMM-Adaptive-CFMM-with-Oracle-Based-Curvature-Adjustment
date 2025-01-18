// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

interface ISubscriptionManagementEvents {
    //@notice: event-transition of a successful subscription
    event Subscribed(
        address indexed liquidityProviderAddress,
        address indexed uniswapPairAddress
    );
    //@notice:
    event DeployedKappaPair(
        address indexed uniswapPairAddress,
        address indexed kappaPair,
        uint32 indexed blockTimestamp
    );
}
