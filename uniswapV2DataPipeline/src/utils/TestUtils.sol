// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUniswapV2Factory} from "@UniswapV2/interfaces/IUniswapV2Factory.sol";

contract TokenPairs {
    address[] public _tokens;
    mapping(bytes32 => bool) public createdPairs;

    /**
     * @dev Create all possible pairs from an arbbitrary list of tokens
     * @param length of the array to token address
     * @param factory address of pair creator
     */

    function createAllPairs(uint256 length, address factory) internal {
        require(length > 1, "Need at least two tokens to create a pair");
        require(
            _tokens.length == length,
            "Mismatch between length and tokens array"
        );

        for (uint256 i = 0; i < length; i++) {
            address tokenA = _tokens[i];

            for (uint256 j = i + 1; j < length; j++) {
                address tokenB = _tokens[j];

                require(tokenA != address(0), "Token A address is invalid");
                require(tokenB != address(0), "Token B address is invalid");

                bytes32 pairHash = keccak256(abi.encodePacked(tokenA, tokenB));

                if (!createdPairs[pairHash]) {
                    IUniswapV2Factory(factory).createPair(tokenA, tokenB);

                    createdPairs[pairHash] = true;
                }
            }
        }
    }
}

/// @title A contract for demonstrating random number generation in specific range
/// @author Jitendra Kumar
/// @notice For now, this contract just show how to generate a random number in specific range using keccak256
contract GeeksForGeeksRandom {
    // Initializing the state variable
    uint randNonce = 0;

    // Defining a function to generate
    // a random number
    function randMod(uint _modulus) internal returns (uint) {
        // increase nonce
        randNonce++;
        return
            uint(
                keccak256(
                    abi.encodePacked(block.timestamp, msg.sender, randNonce)
                )
            ) % _modulus;
    }
}
