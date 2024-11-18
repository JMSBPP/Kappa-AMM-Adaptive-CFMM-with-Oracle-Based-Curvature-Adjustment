pragma solidity ^0.8.0;

interface IStorageRouter {
    /**
     * @dev StorageRouter receives raw data from the PairProcessor
     * and store each pair in different storage contratcs (minimal proxies)
     * that store the pairs according to the segmentation criteria or
     * liquidity threshold
     *
     *
     *
     *
     */

    function storePair(string memory by) external returns (bool);
    function createGroups() external;
}
