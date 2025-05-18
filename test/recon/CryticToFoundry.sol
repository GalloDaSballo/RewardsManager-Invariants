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
        vm.warp(10000000);
        // TODO: add failing property tests here for debugging
        asset_approve(address(rewardsManager), 1e18);
        asset_mint(address(this), 1e18);
        rewardsManager_addReward(rewardsManager.currentEpoch() + 1, address(this), address(_getAsset()), 1e18);
        rewardsManager_notifyTransfer(0, 1, 1e18, true, false);
        doomsday_sum_of_claims();
        canary_totalSupply_atEpoch();
    }   		


}
