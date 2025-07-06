//SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Script, console} from "forge-std/Script.sol";
import {PandoraToken} from "../src/PandoraToken.sol";

contract DeployPandoraToken is Script {
    // This contract is used to deploy the PandoraToken contract
    // It can be used with Foundry or Hardhat
    // To deploy, run: forge create --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> src/PandoraToken.sol:MyToken
    
    uint256 constant INITIAL_SUPPLY = 100_000_000 * 10**18; // 1 million tokens with 18 decimals
    
    function run() external returns (PandoraToken) {
        // Start the script
        vm.startBroadcast();

        // Deploy the PandoraToken contract
        PandoraToken token = new PandoraToken(INITIAL_SUPPLY);

        vm.stopBroadcast();
        console.log("PandoraToken deployed with initial supply of %s tokens", INITIAL_SUPPLY);
        console.log("Contract address: %s", address(token));
        return token;
    }
}