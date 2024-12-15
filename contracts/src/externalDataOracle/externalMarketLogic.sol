// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//I need the logic to upgradable
//I need the logic to be ownable
import {IReactive} from "@Reactive-Network-Contracts/IReactive.sol";
import {IOracle} from "@1-InchPriceOracle/interfaces/IOracle.sol";
contract externalMarketLogic {
    //STATE VARIABLES
    address private externalPriceOracleAddress;
    address private kappaPoolReactiveAddress;

    //EVENTS

    //ERRORS

    //INITIALIZERS

    constructor(
        address _externalPriceOracleAddress,
        address _kappaPoolReactiveAddress
    ) {
        externalPriceOracleAddress = _externalPriceOracleAddress;
        kappaPoolReactiveAddress = _kappaPoolReactiveAddress;
    }
}
