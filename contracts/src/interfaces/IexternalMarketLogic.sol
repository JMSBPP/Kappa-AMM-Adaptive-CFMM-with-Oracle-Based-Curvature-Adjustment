// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IexternalMarketLogic {
    function getRate(address token0, address token1) external returns (uint160);
}
