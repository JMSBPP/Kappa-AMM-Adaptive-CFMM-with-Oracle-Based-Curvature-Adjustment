pragma solidity ^0.8.0;

import {AbstractReactive} from "@Reactive-Network-Contracts/AbstractReactive.sol";

struct SubscriptionKeys {
    uint256 SWAP;
    uint256 MINT;
    uint256 BURN;
    uint256 SYNC;
}

contract UniswapV2PoolMetadata {
    uint256 internal constant _REACTIVE_IGNORE =
        0xa65f96fc951c35ead38878e0f0b7a3c744a6f5ccc1476b313353ce31712313ad;

    address public immutable factory;
    address public immutable router;
    uint256 private immutable chainID;
    address private immutable pool;

    mapping(uint256 => bytes) internal subscriptions;
    SubscriptionKeys internal subscriptionsKeys;

    constructor(address _pool) {
        pool = _pool;
        getSubscriptionsKeys();
    }

    /**
     * @dev gets the subscription keys
     * @notice This method can only be used once
     */
    function getSubscriptionsKeys() private {
        subscriptionsKeys.SWAP = uint(
            keccak256("Swap(address,uint256,uint256,uint256,uint256,address)")
        );

        subscriptionsKeys.MINT = uint(
            keccak256("Mint(address,uint256,uint256)")
        );
        subscriptionsKeys.BURN = uint(
            keccak256("Burn(address,uint256,uint256,address)")
        );
        subscriptionsKeys.SYNC = uint(keccak256("Sync(uint112,uint112)"));
    }

    /**
     * @dev gets the subscriptions bytes, ready to be called
     *
     */

    function getSubscriptions() internal {
        subscriptions[subscriptionsKeys.SYNC] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            subscriptionsKeys.SYNC,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );

        subscriptions[subscriptionsKeys.SWAP] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            subscriptionsKeys.SWAP,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );
        subscriptions[subscriptionsKeys.MINT] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            subscriptionsKeys.MINT,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );

        subscriptions[subscriptionsKeys.BURN] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            subscriptionsKeys.BURN,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );
    }
}

contract OracleMetadata {
    uint256 internal constant _REACTIVE_IGNORE =
        0xa65f96fc951c35ead38878e0f0b7a3c744a6f5ccc1476b313353ce31712313ad;
}
