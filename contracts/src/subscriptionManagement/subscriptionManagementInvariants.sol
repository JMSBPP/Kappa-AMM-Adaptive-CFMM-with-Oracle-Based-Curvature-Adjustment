// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract subscriptionManagementInvariants {
    // Keccak-256 hashes of the event signatures
    uint256 constant UNISWAP_V2_MINT_TOPIC_0 =
        uint256(keccak256("Mint(address,uint256,uint256)"));
    uint256 constant UNISWAP_V2_SWAP_TOPIC_0 =
        uint256(
            keccak256("Swap(address,uint256,uint256,uint256,uint256,address)")
        );
    uint256 constant UNISWAP_V2_BURN_TOPIC_0 =
        uint256(keccak256("Burn(address,uint256,uint256,address)"));

    uint256 constant UNISWAP_V2_SYNC_TOPIC_0 =
        uint256(keccak256("Sync(uint112,uint112)"));

    uint256 constant CHAIN_ID = 1;

    // Additional code and functionalities for your contract go here.
}
