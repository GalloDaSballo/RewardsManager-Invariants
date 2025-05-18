// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import "forge-std/console2.sol";

contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();
    }

    function test_crytic() public {
        // TODO: add failing property tests here for debugging
        asset_approve(address(rewardsManager), 1e18);
        asset_mint(address(this), 1e18);
        rewardsManager_addReward(rewardsManager.currentEpoch() + 1, address(this), address(_getAsset()), 1e18);
        rewardsManager_notifyTransfer(address(0), address(_getActors()[1]), 1e18);
        canary_totalSupply_atEpoch();
    }   		

    // forge test --match-test test_canary_totalSupply_atEpoch_kb40 -vvv
    function test_canary_totalSupply_atEpoch_kb40() public {
    
        rewardsManager_notifyTransfer(0x0000000000000000000000000000000000000000,0x00000000000000000000000000000000DeaDBeef,1);
    
        canary_totalSupply_atEpoch();
    
    }
}
