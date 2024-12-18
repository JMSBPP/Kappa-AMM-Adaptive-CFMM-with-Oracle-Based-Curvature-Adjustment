// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IReactive} from "@Reactive-Network-Contracts/IReactive.sol";
import {AbstractReactive} from "@Reactive-Network-Contracts/AbstractReactive.sol";
import {UniswapV2PoolMetadata} from "../utils/Metadata.sol";

abstract contract kappaPoolReactiveContract is
    UniswapV2PoolMetadata,
    IReactive,
    AbstractReactive
{
    //STATE VARIABLES
    address public immutable pool;
    address public immutable deployer;

    //EVENTS

    event Subscribed(
        address indexed service_address,
        address indexed _contract,
        uint256 indexed topic_0
    );

    event VM();

    constructor(address _pool) UniswapV2PoolMetadata(_pool) {
        //Pool is not modifiable
        pool = _pool;
        deployer = msg.sender;
        getSubscriptions();
    }

    function multiSubscribe()
        external
        payable
        // function subscribe(
        //     uint256 chain_id,
        //     address _contract,
        //     uint256 topic_0,
        //     uint256 topic_1,
        //     uint256 topic_2,
        //     uint256 topic_3
        // ) external;

        //get the event metadata for all Uniswap Actions

        receive
    {}
}
