// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementGuards} from "./subscriptionManagementGuards.sol";
import {ReentrancyGuard} from "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {AbstractPausableReactive} from "../lib/reactive-smart-contract-demos/src/AbstractPausableReactive.sol";

contract subscriptionManagementPermissionedActions is
    subscriptionManagementGuards,
    ReentrancyGuard,
    AbstractPausableReactive
{
    uint256 private constant UNISWAP_V2_TOPIC_0 =
        0x1c411e9a96e071241c2f21f7726b17ae89e3cab4c78be50e062b03a9fffbbad1;

    /**
     * @notice Sets the subscriber status if the
     * uniswap pair address is valid
     * @param uniswapPairAddress address of the pool to subscribe
     * @param liquidityProviderAddress address of the liquidity provider s
     * @param value boolean
     */

    //security:
    //
    //protocol:
    //
    //gas:
    // is this the mmost gas optimal way to do this?
    function setSubscriber(
        address uniswapPairAddress,
        address liquidityProviderAddress,
        bool value
    ) internal nonReentrant {
        subscribers[uniswapPairAddress][liquidityProviderAddress] = value;
    }
    /**
     * @notice Adds a subscriber. This function is
     * only trigger triggered by a
     * checkSubscribePostconditions(
     *      UniswapPairAddress,
     *      liquidityProviderAddress) exit event
     *
     * @param uniswapPairAddress address of the pair
     */
    function addSubscriber(address uniswapPairAddress) internal nonReentrant {
        subscribersCount[uniswapPairAddress] += 1;
    }

    function deployKappaOptimalPool(
        address _uniswapPairAddress
    )
        internal
        PoolDeploymentLock(_uniswapPairAddress)
        nonReentrant
        returns (address _kappaPairAddress)
    {
        //LOW LEVEL DEPLOYMENT
        _kappaPairAddress = address(0);
    }
    function partiallySubscribeToPair(
        uint256 chainId,
        address _uniswapPairAddress
    ) public onlyUniswapV2Pair(_uniswapPairAddress) returns (bool) {
        bytes memory payload = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainId,
            _uniswapPairAddress,
            UNISWAP_V2_TOPIC_0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscription_result, ) = address(service).call(payload);
        if (subscription_result) {
            return true;
        }
        return false;
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
        uint256 hel = uint256(2);
    }
}
