// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IReactive} from "@Reactive-Network-Contracts/IReactive.sol";
import {AbstractReactive} from "@Reactive-Network-Contracts/AbstractReactive.sol";
import {UniswapV2PoolMetadata} from "../utils/Metadata.sol";

enum Initiated {
    UNINITIATED,
    INITIATED
}
abstract contract kappaPoolReactiveContract is
    UniswapV2PoolMetadata,
    IReactive,
    AbstractReactive
{
    //STATE VARIABLES
    address public immutable pool;
    address private externalMarketLogic;
    address public immutable deployer;

    Initiated private initiated;

    //EVENTS

    event Subscribed(
        address indexed service_address,
        address indexed _contract,
        uint256 indexed topic_0
    );

    event VM();
    event CallbackSent();

    //ERRORS

    error NotDeployed();

    constructor(address _pool) UniswapV2PoolMetadata(_pool) {
        //Pool is not modifiable
        require(initiated == Initiated.UNINITIATED, NotDeployed());
        pool = _pool;
        deployer = msg.sender;
        multiSubscribe();
        initiated = Initiated.INITIATED;
    }

    receive() external payable {}

    /**
     * @dev Subscribes to pool events
     * @notice Needs to be heavlily optimized
     */
    function multiSubscribe() private {
        getSubscriptions();
        (bool subscription_MINT, ) = address(service).call(
            subscriptions[subscriptionsKeys.MINT]
        );
        if (!subscription_MINT) {
            vm = true;
            emit VM();
        } else {
            emit Subscribed(address(service), pool, subscriptionsKeys.MINT);
        }
        (bool subscription_BURN, ) = address(service).call(
            subscriptions[subscriptionsKeys.BURN]
        );
        if (!subscription_BURN) {
            vm = true;
            emit VM();
        } else {
            emit Subscribed(address(service), pool, subscriptionsKeys.BURN);
        }
        (bool subscription_SWAP, ) = address(service).call(
            subscriptions[subscriptionsKeys.SWAP]
        );
        if (!subscription_SWAP) {
            vm = true;
            emit VM();
        } else {
            emit Subscribed(address(service), pool, subscriptionsKeys.SWAP);
        }
        (bool subscription_SYNC, ) = address(service).call(
            subscriptions[subscriptionsKeys.SYNC]
        );

        if (!subscription_SYNC) {
            vm = true;
            emit VM();
        } else {
            emit Subscribed(address(service), pool, subscriptionsKeys.SYNC);
        }
    }
    function react(
        uint256 chain_id,
        address _contract,
        uint256 topic_0,
        uint256 topic_1,
        uint256 topic_2,
        uint256 /* topic_3 */,
        bytes calldata data,
        uint256 /* block_number */,
        uint256 /* op_code */
    ) external vmOnly {}
}
