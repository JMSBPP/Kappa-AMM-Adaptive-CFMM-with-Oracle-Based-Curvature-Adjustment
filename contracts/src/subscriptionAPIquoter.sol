// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {AbstractPausableReactive} from "../lib/reactive-smart-contract-demos/src/AbstractPausableReactive.sol";
import {subscriptionManagementGuards} from "./subscriptionManagementGuards.sol";
import {payableWrapper} from "./payableWrapper.sol";

//THIS CONTRACT IS ONLY CALLABLE BY
//THE SUBSCRIPTION MANAGER ACTIONS
contract subscriptionAPIquoter is
    subscriptionManagementGuards,
    AbstractPausableReactive,
    payableWrapper
{
    Subscription[] private susbcriptions;

    function getReactiveCost(
        address _uniswapPairAddress,
        bool isFirstSubscription
    ) external payable returns (uint256 reactiveCost) {
        if (!(isFirstSubscription == getSubscription(_uniswapPairAddress))) {
            revert isNotFirstSubscription();
        }

        if (isFirstSubscription) {
            reactiveCost = partiallySubscribe(_uniswapPairAddress);
        }
    }
    function getSubscription(
        address _uniswapPairAddress
    ) private view returns (bool res) {
        for (
            uint256 index = 0;
            index != getPausableSubscriptions().length;
            index++
        ) {
            if (
                getPausableSubscriptions()[index]._contract ==
                _uniswapPairAddress
            ) {
                res = true;
            }
        }
        res = false;
    }

    function partiallySubscribe(
        address _uniswapPairAddress
    ) private returns (uint256 cummulativeDebt) {
        bytes memory payloadSwap = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            CHAIN_ID,
            _uniswapPairAddress,
            UNISWAP_V2_SWAP_TOPIC_0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscriptionResultSwap, ) = address(service).call(payloadSwap);
        if (subscriptionResultSwap) {
            cummulativeDebt = cummulativeDebt + debt(address(this));
        } else {
            revert subscriptionFailed();
        }

        bytes memory payloadBurn = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            CHAIN_ID,
            _uniswapPairAddress,
            UNISWAP_V2_BURN_TOPIC_0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscriptionResultBurn, ) = address(service).call(payloadBurn);
        if (subscriptionResultBurn) {
            cummulativeDebt = cummulativeDebt + debt(address(this));
        } else {
            revert subscriptionFailed();
        }
        bytes memory payloadSync = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            CHAIN_ID,
            _uniswapPairAddress,
            UNISWAP_V2_SYNC_TOPIC_0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscriptionResultSync, ) = address(service).call(payloadSync);
        if (subscriptionResultSync) {
            cummulativeDebt = cummulativeDebt + debt(address(this));
        } else {
            revert subscriptionFailed();
        }

        bytes memory payloadMint = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            CHAIN_ID,
            _uniswapPairAddress,
            UNISWAP_V2_MINT_TOPIC_0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscriptionResultMint, ) = address(service).call(payloadMint);
        if (subscriptionResultMint) {
            cummulativeDebt = cummulativeDebt + debt(address(this));
            susbcriptions.push(
                Subscription({
                    chain_id: CHAIN_ID,
                    _contract: _uniswapPairAddress,
                    topic_0: UNISWAP_V2_MINT_TOPIC_0,
                    topic_1: REACTIVE_IGNORE,
                    topic_2: REACTIVE_IGNORE,
                    topic_3: REACTIVE_IGNORE
                })
            );
        } else {
            revert subscriptionFailed();
        }
    }

    receive() external payable {}

    function react(
        uint256 chain_id,
        address _contract,
        uint256 topic_0,
        uint256 topic_1,
        uint256 topic_2,
        uint256 topic_3,
        bytes calldata data,
        uint256 block_number,
        uint256 op_code
    ) external {
        uint256 result = 0;
    }

    function getPausableSubscriptions()
        internal
        view
        override
        returns (Subscription[] memory)
    {
        return susbcriptions;
    }
}
