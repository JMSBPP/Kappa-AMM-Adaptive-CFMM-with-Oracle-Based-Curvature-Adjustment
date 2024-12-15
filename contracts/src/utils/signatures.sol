// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Signatures {
    struct eventMetaData {
        bytes4 eventSignature;
        uint256 topic0;
        uint256 topic1;
        uint256 topic2;
        uint256 topic3;
        bytes data;
    }

    function _getEventMetadata(
        string memory eventName
    ) internal pure returns (eventMetaData memory result) {
        bytes32 hashedName = keccak256(abi.encodePacked(eventName));

        // Mint Event
        if (hashedName == keccak256("Mint")) {
            result.eventSignature = bytes4(
                keccak256("Mint(address,uint256,uint256)")
            );
            result.topic0 = uint256(keccak256("address(address)"));
            result.topic1 = uint256(keccak256("uint256"));
            result.topic2 = uint256(keccak256("uint256"));
            result.topic3 = 0; // No indexed topic3
            result.data = ""; // Default empty data
        }
        // Burn Event
        else if (hashedName == keccak256("Burn")) {
            result.eventSignature = bytes4(
                keccak256("Burn(address,uint256,uint256,address)")
            );
            result.topic0 = uint256(keccak256("address(address)"));
            result.topic1 = uint256(keccak256("uint256"));
            result.topic2 = uint256(keccak256("uint256"));
            result.topic3 = uint256(keccak256("address(address)"));
            result.data = ""; // Default empty data
        }
        // Swap Event
        else if (hashedName == keccak256("Swap")) {
            result.eventSignature = bytes4(
                keccak256(
                    "Swap(address,uint256,uint256,uint256,uint256,address)"
                )
            );
            result.topic0 = uint256(keccak256("address(address)"));
            result.topic1 = uint256(keccak256("uint256"));
            result.topic2 = uint256(keccak256("uint256"));
            result.topic3 = uint256(keccak256("address(address)"));
            result.data = ""; // Default empty data
        }
        // Sync Event
        else if (hashedName == keccak256("Sync")) {
            result.eventSignature = bytes4(keccak256("Sync(uint112,uint112)"));
            result.topic0 = uint256(keccak256("uint112"));
            result.topic1 = uint256(keccak256("uint112"));
            result.topic2 = 0; // No indexed topic2
            result.topic3 = 0; // No indexed topic3
            result.data = ""; // Default empty data
        }
        // Unrecognized Event
        else {
            revert("Event name not recognized");
        }
    }
}
