pragma solidity ^0.8.0;

import {UniswapV2FactoryHook} from "../src/UniswapV2FactoryHook.sol";
import {Test, console} from "forge-std/Test.sol";
import {MockERC20} from "forge-std/mocks/MockERC20.sol";
import {UniswapV2Factory} from "@UniswapV2/UniswapV2Factory.sol";
contract UniswapV2FactoryHookTest is Test {
    UniswapV2FactoryHook private hook;
    UniswapV2Factory private factory;
    MockERC20 private token0;
    MockERC20 private token1;

    function setUp() public {
        factory = new UniswapV2Factory(address(0));
        hook = new UniswapV2FactoryHook(address(factory));
        token0 = new MockERC20();
        token1 = new MockERC20();

        token0.initialize("A", "A", 18);
        token1.initialize("B", "B", 18);
        factory.createPair(token0.address, token1.address);
        factory.createPair(token1.address, token0.address);
    }
}
