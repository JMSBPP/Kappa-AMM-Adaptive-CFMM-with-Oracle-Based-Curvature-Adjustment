pragma solidity ^0.8.0;

import {UniswapV2FactoryHook} from "../src/UniswapV2FactoryHook.sol";
import {Test, console} from "forge-std/Test.sol";
import {MockERC20} from "forge-std/mocks/MockERC20.sol";
import {UniswapV2Factory} from "@UniswapV2/UniswapV2Factory.sol";
import "../src/utils/StringUtils.sol";
import "../src/utils/TestUtils.sol";

contract UniswapV2FactoryHookTest is Test, TokenPairs, GeeksForGeeksRandom {
    using RandomStringGenerator for uint256;

    uint8 private DECIMALS = 18;
    UniswapV2FactoryHook private hook;
    UniswapV2Factory private factory;
    address[] private tokens;

    function setUp() public {
        //Create an arbitrary amount of pairs
        uint256 numbPairs = randMod(uint256(DECIMALS));
        factory = new UniswapV2Factory(address(0));
        hook = new UniswapV2FactoryHook(address(factory));
        MockERC20 token;
        tokens = new address[](numbPairs);

        for (uint i = 0; i < numbPairs; i++) {
            token = new MockERC20();
            tokens[i] = address(token);
            string memory tokenMetaData = i.generateRandomString();
            token.initialize(tokenMetaData, tokenMetaData, DECIMALS);
        }

        _tokens = tokens;

        createAllPairs(numbPairs, address(factory));
    }

    function testGetPair() external {
        factory.allPairsLength();
        hook.getAllPairs();
    }
}
