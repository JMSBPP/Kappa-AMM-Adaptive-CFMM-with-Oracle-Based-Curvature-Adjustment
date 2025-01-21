// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {ISystemContract} from "../lib/reactive-smart-contract-demos/src/ISystemContract.sol";

//CONTRACT DEPLOYED IN THE REACTIVE NETWORK
contract payableWrapper {
    ISystemContract internal constant SERVICE =
        ISystemContract(payable(0x0000000000000000000000000000000000fffFfF));

    function debt(address _contract) internal view returns (uint256) {
        return SERVICE.debt(_contract);
    }
}
