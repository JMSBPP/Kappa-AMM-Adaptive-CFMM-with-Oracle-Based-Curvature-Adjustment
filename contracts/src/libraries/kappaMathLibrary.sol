// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {Math} from "@OpenZeppelin/contracts/utils/math/Math.sol";
library kappaMathLibrary {
    using Math for uint256;
    // uint112 private reserve0; // uses single storage slot, accessible via getReserves
    // uint112 private reserve1; // uses single storage slot, accessible via getReserves
    // uint32 private blockTimestampLast; // uses single storage slot, accessible via getReserves

    // uint256 public override price0CumulativeLast;
    // uint256 public override price1CumulativeLast;
    // uint256 public override kLast; // reserve0 * reserve1, as of immediately after the most recent liquidity event
    function curvatureNumerator(
        uint256 reserve0,
        uint256 reserve1,
        uint256 amount0
    ) internal returns (uint256) {
        (bool res1, uint256 firstTerm) = amount0.tryMul(uint256(2));
        require(res1, "NOT ABLE");
        (bool res2, uint256 secondTerm) = firstTerm.tryAdd(reserve1);
        require(res2, "NOT ABLE");
    }
}
