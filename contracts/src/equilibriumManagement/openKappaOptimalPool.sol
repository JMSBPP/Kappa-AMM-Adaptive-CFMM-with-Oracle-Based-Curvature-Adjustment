// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {kappaPoolStates} from "./kappaPoolState.sol";
import {IkappaErrors} from "./interfaces/IkappaErrors.sol";
import {IkappaEvents} from "./interfaces/IkappaEvents.sol";

contract openKappaOptimalPool is kappaPoolStates, IkappaErrors, IkappaEvents {
    constructor(address _volumeRouter) {}
}
