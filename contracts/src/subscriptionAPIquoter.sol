// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {AbstractPausableReactive} from "../lib/reactive-smart-contract-demos/src/AbstractPausableReactive.sol";
import {subscriptionManagementPermissionedActions} from "./subscriptionManagementPermissionedActions.sol";
import {payableWrapper} from "./payableWrapper.sol";
//THIS CONTRACT IS ONLY CALLABLE BY
//THE SUBSCRIPTION MANAGER ACTIONS
abstract contract subscriptionAPIquoter is
    subscriptionManagementPermissionedActions,
    AbstractPausableReactive,
    payableWrapper
{
    function getReactiveCost(
        address _uniswapPairAddress,
        bool isFirstSubscription
    ) public payable returns (uint256 reactiveCost) {
        if (!(isFirstSubscription == getSubscription(_uniswapPairAddress))) {
            revert isNotFisrtSubscription();
        }

        if (isFirstSubscription) {
            reactiveCost = 0;
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
        } else {
            revert subscriptionFailed();
        }
    }

    receive() external payable {}
}
