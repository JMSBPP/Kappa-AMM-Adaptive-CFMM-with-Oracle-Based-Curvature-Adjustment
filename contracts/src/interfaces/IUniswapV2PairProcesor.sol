pragma solidity ^0.8.0;

interface IUniswapV2PairProcesor {
    /**
     * @dev Pair Processor responds to inital bulk upload oof all pairs
     * and also reponds to the pairs added by the PairCreated
     * event listened by the UniswapV2PFactoryHook contract
     *  @notice PairProcessor provides data for each pair and forwards
     * it to the StorageRouter contract
     *
     *
     *
     */

    event StateVars(bytes dataVars);

    function getPairData(bytes memory data) external;
    function getStateVars(
        address pair
    ) external returns (bytes memory dataVars);
}
