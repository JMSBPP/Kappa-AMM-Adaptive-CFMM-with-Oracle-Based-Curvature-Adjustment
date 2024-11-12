pragma solidity ^0.8.0;

import "@reactiveContracts/contracts/src/AbstractReactive.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@Uniswapv2-core/interfaces/IUniswapV2Factory.sol";

contract UniswapV2FactoryHooker is AbstractReactive, Initializable {
    bytes4 constant GET_PAIRS_SIGNATURE = bytes4(keccak256("allPairs(uint)"));

    uint8 private chainID;
    address private factory;

    event InitBulk(bool success, bytes data);

    /**
     * @dev Returns all pairs created by the factory encoded as bytes
    
    */
    function getAllPairs() public view returns (bytes memory data) {
        uint256 length = IUniswapV2Factory(factory).allPairsLength();
        for (uint256 i = 0; i < length; i++) {
            address pair = IUniswapV2Factory(factory).allPairs(i);
            data = abi.encodePacked(data, pair);
        }

        emit InitBulk(true, data);
    }

    receive() external payable;
}
