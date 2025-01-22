// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract kappaPoolStates {
    enum KappaPoolState {
        INITIALIZED,
        CLOSING,
        CLOSED,
        READY_FOR_SELF_DESTRUCT
    }

    enum Categorization {
        SHORTGAGED,
        SUPPLY_SURPLUS,
        EQUILIBRIUM
    }

    Categorization private categorization;
    KappaPoolState private state;
    uint256 public curvature;

    address immutable volumeRouter;

    constructor(address _volumeRouter) {
        volumeRouter = _volumeRouter;
    }
}
