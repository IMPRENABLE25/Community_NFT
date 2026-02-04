// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {Nbasic} from "../src/Nbasic.sol";

contract DeployNbasic is Script {
    function run() external {
        vm.startBroadcast();
        string
            memory initialURI = "ipfs://bafkreigkaikw45dw4zoun343bpksjucuqdeljagare7n6nbbhmb46vuuoa/";

        Nbasic nbasic = new Nbasic(initialURI);

        console.log("Contract deploye:", address(nbasic));
        vm.stopBroadcast();
    }
}
