// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {IUniswapV2Pair} from "@UniswapV2/interfaces/IUniswapV2Pair.sol";
import {IUniswapV2Factory} from "@UniswapV2/interfaces/IUniswapV2Factory.sol";
import {subscriptionManagementState} from "./subscriptionManagementState.sol";
import {subscriptionManagementInvariants} from "./subscriptionManagementInvariants.sol";
contract subscriptionManagementGuards is
    subscriptionManagementState,
    subscriptionManagementInvariants
{
    modifier onlyUniswapV2Pair(address _uniswapPairAddress) {
        require(isUniswapV2Pair(_uniswapPairAddress), "Not a Uniswap V2 pair");
        _;
    }

    /**
     * @notice This function checks if the given address is a Uniswap V2 pair.
     * THIS FUNCTION ENABLES US TO USE THE
     * subscribers[UniswapPairAddress][liquidityProviderAddress]
     * MAPPING
     * @param uniswapPairAddress The address of the Uniswap pair to check.
     * @return bool True if the address is a valid Uniswap V2 pair, false otherwise.
     */
    // security:
    // How an attacker would attack this function,
    // What incentives would he has to do so?
    //protocol:
    //
    // gas:
    //  is this gas efficient?
    function isUniswapV2Pair(
        address uniswapPairAddress
    ) internal view returns (bool) {
        address token0 = IUniswapV2Pair(uniswapPairAddress).token0();
        address token1 = IUniswapV2Pair(uniswapPairAddress).token1();
        address factory = IUniswapV2Pair(uniswapPairAddress).factory();

        return
            IUniswapV2Factory(factory).getPair(token0, token1) ==
            uniswapPairAddress;
    }
}
