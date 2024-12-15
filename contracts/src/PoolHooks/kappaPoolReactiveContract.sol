// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IReactive} from "@Reactive-Network-Contracts/IReactive.sol";
import {AbstractReactive} from "@Reactive-Network-Contracts/AbstractReactive.sol";
import {Signatures} from "../utils/signatures.sol";

struct chainMetadata {
    address factoryAddress;
    address routerAddress;
}

contract kappaPoolReactiveContract is Signatures, IReactive, AbstractReactive {
    //STATE VARIABLES
    address public pool;
    uint256 public chainId;

    mapping(string => eventMetaData) public actionType;
    mapping(uint256 chainId => chainMetadata) public PoolAPIInfo;

    //EVENTS

    event Subscribed(
        address indexed service_address,
        address indexed _contract,
        uint256 indexed topic_0
    );

    event VM();

    constructor(address _pool, uint256 _chainID) {
        //Pool is not modifiable
        pool = _pool;
        chainId = _chainID;
        bool res = getEventMetadata();
        require(res, "FAILED TO GET EVENT METADATA");
        susbcribeToEvents();
    }
    //get the event metadata for all Uniswap Actions
    function getEventMetadata() internal returns (bool success) {
        string[4] memory events = ["Swap", "Burn", "Mint", "Sync"];
        for (uint256 i = 0; i < events.length; i++) {
            actionType[events[i]] = _getEventMetadata(events[i]);
        }
        return success;
    }

    function susbcribeToEvents() internal returns (bool success) {
        string[4] memory events = ["Swap", "Burn", "Mint", "Sync"];
        for (uint256 i = 0; i < events.length; i++) {
            bytes memory payload = abi.encodeWithSignature(
                "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
                chainId,
                pool,
                actionType[events[i]].topic0,
                REACTIVE_IGNORE,
                REACTIVE_IGNORE,
                REACTIVE_IGNORE
            );
            (bool subscription_result, ) = address(service).call(payload);
            if (!subscription_result) {
                vm = true;
                emit VM();
            } else {
                emit Subscribed(
                    address(service),
                    pool,
                    actionType[events[i]].topic0
                );
            }
        }
    }

    receive() external payable {}
}
