// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {openKappaOptimalPool} from "./openKappaOptimalPool.sol";
contract surplusKappaOptimalPool is openKappaOptimalPool {
    constructor(address _volumeRouter) openKappaOptimalPool(_volumeRouter) {}
}
