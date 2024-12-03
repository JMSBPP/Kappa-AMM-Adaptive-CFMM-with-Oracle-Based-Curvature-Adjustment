pragma solidity ^0.8.0;

import "@ReactiveContracts/contracts/AbstractReactive.sol";
import "@ReactiveContracts/contracts/IReactive.sol";
import "@Openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@UniswapV2/interfaces/IUniswapV2Factory.sol";

contract UniswapV2FactoryHook is IReactive, AbstractReactive, Initializable {
    address private constant SERVICE_ADDRESS =
        0x0000000000000000000000000000000000fffFfF;
    /**
     * @dev Includes the topic0 of the pair creation in the
     * Uniswap Factory contract
     *
     */
    // event PairCreated(address indexed token0, address indexed token1, address pair, uint)
    uint256 private constant PAIR_CREATED_TOPIC0 =
        uint256(keccak256("PairCreated(address,address,address,uint256)"));
    /**
     * @dev Reactive network state variables upgradable
     * depending on
     * 1. How much gas is gilling to spend
     * 2. The Chain ID of the deployed Factory contract
     * 3. Factory contract is subject to the chain ID
     */
    uint256 private chainID;
    address private UniswapFactoryAddress;
    uint64 private gasLimit;
    address private PairProcessorContractAddress;

    event InitBulk(bool success, bytes data);

    constructor(address _UniswapFactoryAddress) {
        UniswapFactoryAddress = _UniswapFactoryAddress;
        service = ISystemContract(payable(SERVICE_ADDRESS));
        bytes memory payload = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            chainID,
            UniswapFactoryAddress,
            PAIR_CREATED_TOPIC0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscription_result, ) = address(service).call(payload);
        vm = !subscription_result;
    }

    /**
     * @dev Returns all pairs created by the factory encoded as bytes
    
    */

    function getAllPairs() public returns (bytes memory data) {
        uint256 length = IUniswapV2Factory(UniswapFactoryAddress)
            .allPairsLength();
        data = new bytes(length * 20);

        for (uint256 i = 0; i < length; i++) {
            address pair = IUniswapV2Factory(UniswapFactoryAddress).allPairs(i);
            assembly {
                mstore(add(add(data, 0x20), mul(i, 20)), shl(96, pair))
            }
        }
        emit InitBulk(true, data);
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
        if (topic_0 == PAIR_CREATED_TOPIC0) {
            bytes memory payload = abi.encodeWithSignature(
                "callback(address)",
                address(PairProcessorContractAddress)
            );
            emit Callback(chain_id, _contract, gasLimit, payload);
        }
    }
}
