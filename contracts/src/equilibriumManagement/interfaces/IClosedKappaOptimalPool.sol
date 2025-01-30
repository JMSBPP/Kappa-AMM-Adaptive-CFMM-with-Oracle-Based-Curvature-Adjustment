// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

interface IClosedKappaOptimalPool {
    event TransferOutstandingInventories(
        uint256 amount,
        address indexed liquidityProviderAddress
    ) anonymous;

    event Initialized(address openKappaOptimalPoolAddress, uint256 timeStamp);
    event Terminated(address openKappaOptimalPoolAddress, uint256 timeStamp);

    event requestUsubscribe(
        address openKappaOptimalPoolAddress,
        uint256 timeStamp
    ) anonymous;
}
