// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

interface ISubscriptionManagementEvents {
    //@notice: response of a successful subscription
    event Subscribed(
        address indexed liquidityProviderAddress,
        address indexed uniswapPairAddress,
        uint256 indexed kappaPairAddress,
        uint256 amount
    );
}
