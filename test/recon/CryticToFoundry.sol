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

    // forge test --match-test test_canary_totalSupply_atEpoch_lckx -vvv
    function test_canary_totalSupply_atEpoch_lckx() public {
    
        vm.roll(block.number + 23403);
        vm.warp(block.timestamp + 50417);
        rewardsManager_notifyTransfer(0x0000000000000000000000000000000000000000,0x00000000000000000000000000000000FFFFfFFF,115792089237316195423570985008687907853269984665640564039457584007913129639929);
    
        vm.roll(block.number + 23722);
        vm.warp(block.timestamp + 434894);
        solvency_totalSupply_atEpoch();
    
        vm.roll(block.number + 5952);
        vm.warp(block.timestamp + 249040);
        rewardsManager_addReward(722,0x00000000000000000000000000000001fffffffE,0x00000000000000000000000000000002fFffFffD,4369999);
    
        vm.roll(block.number + 23403);
        vm.warp(block.timestamp + 136393);
        rewardsManager_claimRewardEmitting(115792089237316195423570985008687907853269984665640564039457584007913129035135,0x00000000000000000000000000000000FFFFfFFF,0x00000000000000000000000000000001fffffffE,0x00000000000000000000000000000002fFffFffD);
    
        vm.roll(block.number + 58783);
        vm.warp(block.timestamp + 600848);
        rewardsManager_claimReward(359,0x0000000000000000000000000000000000010000,0x00000000000000000000000000000002fFffFffD,0x00000000000000000000000000000000FFFFfFFF);
    
        vm.roll(block.number + 5014);
        vm.warp(block.timestamp + 600847);
        rewardsManager_claimRewardReferenceEmitting(115792089237316195423570985008687907853269984665640564039457584007913096099417,0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496,0x00000000000000000000000000000002fFffFffD,0x00000000000000000000000000000002fFffFffD);
    
        vm.roll(block.number + 31);
        vm.warp(block.timestamp + 447588);
        claim_rewards_never_reverts();
    
        vm.roll(block.number + 19948);
        vm.warp(block.timestamp + 17);
        claim_rewards_never_reverts();
    
    }
}
