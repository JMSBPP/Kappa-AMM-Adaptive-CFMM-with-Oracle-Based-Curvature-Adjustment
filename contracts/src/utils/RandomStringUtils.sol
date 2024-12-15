// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library RandomStringGenerator {
    /**
     * @dev Returns a random string
     */
    function generateRandomString(
        uint256 input
    ) public pure returns (string memory) {
        bytes32 hash = keccak256(abi.encodePacked(input));

        string memory randomString = toHexString(hash);

        return randomString;
    }

    /**
     * @dev Helper function to convert bytes32 to hex string
     */
    function toHexString(bytes32 data) internal pure returns (string memory) {
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(64); // 32 bytes * 2 hex characters per byte = 64 chars
        for (uint256 i = 0; i < 32; i++) {
            str[i * 2] = alphabet[uint8(data[i] >> 4)];
            str[i * 2 + 1] = alphabet[uint8(data[i] & 0x0f)];
        }
        return string(str);
    }
}
