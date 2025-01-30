// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {kappaPoolStates} from "./kappaPoolState.sol";
import {IClosedKappaOptimalPool} from "./interfaces/IClosedKappaOptimalPool.sol";
contract closedKappaOptimalPool is kappaPoolStates, IClosedKappaOptimalPool {}
