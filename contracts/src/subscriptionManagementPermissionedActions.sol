// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementGuards} from "./subscriptionManagementGuards.sol";
import {ReentrancyGuard} from "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {subscriptionAPIquoter} from "./subscriptionAPIquoter.sol";
import {kappaOptimalPool} from "./kappaOptimalPool.sol";

contract subscriptionManagementPermissionedActions is
    subscriptionManagementGuards,
    ReentrancyGuard
{
    bytes32 public constant KAPPA_HASH =
        keccak256(type(kappaOptimalPool).creationCode);

    address immutable APIQuoterAddress;

    constructor(address _APIQuoterAddress) {
        APIQuoterAddress = _APIQuoterAddress;
    }

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
        address _uniswapPairAddress,
        address liqudidityProviderAddress
    )
        internal
        PoolDeploymentLock(_uniswapPairAddress)
        nonReentrant
        hasValidVolumeRouter
        returns (address _kappaPairAddress)
    {
        //get reactive cost
        bytes memory payload = abi.encodeWithSignature(
            "getReactiveCost(address,bool)",
            _uniswapPairAddress,
            true
        );
        (bool res, bytes memory data) = address(APIQuoterAddress).call{
            value: msg.value
        }(payload);

        if (res) {
            uint256 cost = abi.decode(data, (uint256));
            if (msg.value <= cost) {
                revert InsufficienFundsToSubscribe();
            }
            address volumeRouter = getVolumeRouter();

            _kappaPairAddress = address(
                new kappaOptimalPool{
                    salt: keccak256(abi.encodePacked(_uniswapPairAddress))
                }(volumeRouter)
            );

            emit DeployedKappaPair(
                _uniswapPairAddress,
                _kappaPairAddress,
                block.timestamp
            );
        }
    }

    function setToReadyToReceiveSubscribers(
        address liquidityProviderAddress
    ) internal nonReentrant {
        subscriptionState[liquidityProviderAddress] = SubscriptionState.IDLE;
    }
}
