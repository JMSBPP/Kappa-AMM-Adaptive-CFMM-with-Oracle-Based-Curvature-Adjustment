// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {subscriptionManagementGuards} from "./subscriptionManagementGuards.sol";
import {ReentrancyGuard} from "../../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {openKappaOptimalPool} from "../equilibriumManagement/openKappaOptimalPool.sol";

contract subscriptionManagementPermissionedActions is
    subscriptionManagementGuards,
    ReentrancyGuard
{
    bytes32 public constant KAPPA_HASH =
        keccak256(type(openKappaOptimalPool).creationCode);

    address immutable APIQuoterAddress;

    // /**
    //  * @notice Sets the subscriber status if the
    //  * uniswap pair address is valid
    //  * @param uniswapPairAddress address of the pool to subscribe
    //  * @param liquidityProviderAddress address of the liquidity provider s
    //  * @param value boolean
    //  */

    //security:
    //
    //protocol:
    //
    //gas:
    // is this the mmost gas optimal way to do this?

    function getKappaAddress() internal returns (address kapppa) {
        return address(0);
    }
    function setSubscriber(
        address uniswapPairAddress,
        address liquidityProviderAddress,
        bool value
    ) internal nonReentrant {
        subscribers[liquidityProviderAddress][uniswapPairAddress]
            .uniswapPairAddress = uniswapPairAddress;
        subscribers[liquidityProviderAddress][uniswapPairAddress]
            .kappaAddress = getKappaAddress();
        subscribers[liquidityProviderAddress][uniswapPairAddress].state = value;
    }
    // /**
    //  * @notice Adds a subscriber. This function is
    //  * only trigger triggered by a
    //  * checkSubscribePostconditions(
    //  *      UniswapPairAddress,
    //  *      liquidityProviderAddress) exit event
    //  *
    //  * @param uniswapPairAddress address of the pair
    //  */
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
                new openKappaOptimalPool{
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
