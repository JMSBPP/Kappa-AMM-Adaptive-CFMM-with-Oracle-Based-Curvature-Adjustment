// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

interface ISubscriptionManagementErrors {
    // @notice: emitted when address does not correspond to
    // a valid UniswapV2Pool. This is used when verifying if
    // a liquidity provider is subscribed to a pool

    error NotValidUniswapV2Pair();
}
