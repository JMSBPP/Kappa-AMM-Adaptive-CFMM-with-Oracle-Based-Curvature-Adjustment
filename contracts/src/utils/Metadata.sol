pragma solidity ^0.8.0;

import {AbstractReactive} from "@Reactive-Network-Contracts/AbstractReactive.sol";

contract UniswapV2PoolMetadata {
    address public immutable factory;
    address public immutable router;
    uint256 private immutable chainID;
    address private immutable pool;

    uint256 private constant SWAP =
        uint(
            keccak256("Swap(address,uint256,uint256,uint256,uint256,address)")
        );
    uint256 private constant MINT =
        uint(keccak256("Mint(address,uint256,uint256)"));
    uint256 private constant BURN =
        uint(keccak256("Burn(address,uint256,uint256,address)"));
    uint256 private constant SYNC = uint(keccak256("Sync(uint112,uint112)"));
    uint256 internal constant _REACTIVE_IGNORE =
        0xa65f96fc951c35ead38878e0f0b7a3c744a6f5ccc1476b313353ce31712313ad;
    mapping(uint256 => bytes) private subscriptions;
    constructor(address _pool) {
        pool = _pool;
    }

    function getSubscriptions() internal {
        subscriptions[SYNC] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            SYNC,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );
        subscriptions[SWAP] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            SWAP,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );
        subscriptions[MINT] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            MINT,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );
        subscriptions[BURN] = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            pool,
            BURN,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE,
            _REACTIVE_IGNORE
        );
    }
}
