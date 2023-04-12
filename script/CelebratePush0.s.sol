// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.19;

import "forge-std/Script.sol";

// --------------------
// INIT CODE:
// push3 0x5f5ff3
// push0
// mstore
// push1 0x03
// push1 0x1d
// return
// --------------------
// --------------------
// RUNTIME CODE:
// push0
// push0
// return
// --------------------
uint256 constant initcode = 0x62_5f_5f_f3_5f_52_60_03_60_1d_f3;

uint256 constant msgValue = 0;
uint256 constant initcodeSize = 11;
uint256 constant initcodeOffset = 21;

contract CelebratePush0Script is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        assembly {
            mstore(0x00, initcode)
            pop(create(msgValue, initcodeOffset, initcodeSize))
        }
    }
}
