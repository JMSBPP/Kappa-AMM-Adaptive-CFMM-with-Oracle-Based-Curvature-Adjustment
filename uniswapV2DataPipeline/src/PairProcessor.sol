// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.0;

import {IUniswapV2PairProcesor} from "./interfaces/IUniswapV2PairProcesor.sol";
import "@ReactiveContracts/contracts/AbstractReactive.sol";
import "@ReactiveContracts/contracts/IReactive.sol";

// address public factory;
// address public token0;
// address public token1;

// uint112 private reserve0;           // uses single storage slot, accessible via getReserves
// uint112 private reserve1;           // uses single storage slot, accessible via getReserves
// uint32  private blockTimestampLast; // uses single storage slot, accessible via getReserves

// uint public price0CumulativeLast;
// uint public price1CumulativeLast;
// uint public kLast; // reserve0 * reserve1, as of immediately after the most recent liquidity event

struct PairMetaData {
    address pair;
    address tokenIndexer;
    address tokenPaired;
    uint orderOfCreation;
}

contract PairProcessor is IUniswapV2PairProcesor, IReactive, AbstractReactive {
    /**
     * @dev Pair Processor responds to inital bulk upload of all pairs
     * and also reponds to the pairs added by the PairCreated
     * event listened by the UniswapV2PFactoryHook contract
     *  @notice PairProcessor provides data for each pair and forwards
     * it to the StorageRouter contract
     *
     *
     *
     */

    //========REACTIVE NETWORK STATE VARIABLES===========
    address private constant SERVICE_ADDRESS =
        0x0000000000000000000000000000000000fffFfF;
    uint256 private constant INIT_BULK_TOPIC0 =
        uint256(keccak256("InitBulk(bool,bytes)"));

    address private storageRouterAddress;
    uint64 private gasLimit;
    //===============REACTIVE VM STATE VARIABLES=============
    PairMetaData[] private PairsMetaData;
    address[] private tokens;

    event StateVars(address indexed pair, bytes dataVars);

    constructor(address factoryHook, uint256 chainID) {
        service = ISystemContract(payable(SERVICE_ADDRESS));
        bytes memory payload = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            factoryHook,
            INIT_BULK_TOPIC0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscription_result, ) = address(service).call(payload);
        vm = !subscription_result;
    }

    function getPairData(bytes memory data) public override {
        uint i = 1;
    }

    function getStateVars(
        address pair
    ) public override returns (bytes memory dataVars) {
        dataVars = new bytes(0);
    }

    receive() external payable {}

    function react(
        uint256 chain_id,
        address _contract,
        uint256 topic_0,
        uint256 topic_1,
        uint256 topic_2,
        uint256 topic_3,
        bytes calldata data,
        uint256 block_number,
        uint256 op_code
    ) external vmOnly {
        if (topic_0 == INIT_BULK_TOPIC0) {
            bytes memory payload = abi.encodeWithSignature(
                "callback(address)",
                address(storageRouterAddress)
            );
            emit Callback(chain_id, _contract, gasLimit, payload);
        }
    }
}
