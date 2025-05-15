// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/RewardsManager.sol";

abstract contract RewardsManagerTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function rewardsManager_accrueUser_clamped(uint256 epochId) public {
        rewardsManager_accrueUser(epochId, address(this), _getActor());
    }


    function rewardsManager_accrueVault_clamped(uint256 epochId) public {
        rewardsManager_accrueVault(epochId, address(this));
    }

    function rewardsManager_addReward_clamped(uint256 epochId, uint256 amt) public {
        rewardsManager_addReward(epochId, address(this), _getAsset(), amt);
    }

    function rewardsManager_claimReward_clamped(uint256 epochId) public {
        rewardsManager_claimReward(epochId, address(this), _getAsset(), _getActor());
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function rewardsManager_accrueUser(uint256 epochId, address vault, address user) public asActor {
        rewardsManager.accrueUser(epochId, vault, user);
    }

    function rewardsManager_accrueVault(uint256 epochId, address vault) public asActor {
        rewardsManager.accrueVault(epochId, vault);
    }

    function rewardsManager_addBulkRewards(uint256 epochStart, uint256 epochEnd, address vault, address token, uint256[] memory amounts) public asActor {
        rewardsManager.addBulkRewards(epochStart, epochEnd, vault, token, amounts);
    }

    function rewardsManager_addBulkRewardsLinearly(uint256 epochStart, uint256 epochEnd, address vault, address token, uint256 total) public asActor {
        rewardsManager.addBulkRewardsLinearly(epochStart, epochEnd, vault, token, total);
    }

    function rewardsManager_addReward(uint256 epochId, address vault, address token, uint256 amount) public asActor {
        rewardsManager.addReward(epochId, vault, token, amount);
    }

    function rewardsManager_claimBulkTokensOverMultipleEpochs(uint256 epochStart, uint256 epochEnd, address vault, address[] memory tokens, address user) public asActor {
        rewardsManager.claimBulkTokensOverMultipleEpochs(epochStart, epochEnd, vault, tokens, user);
    }

    function rewardsManager_claimReward(uint256 epochId, address vault, address token, address user) public asActor {
        rewardsManager.claimReward(epochId, vault, token, user);
    }

    function rewardsManager_claimRewardEmitting(uint256 epochId, address vault, address token, address user) public asActor {
        rewardsManager.claimRewardEmitting(epochId, vault, token, user);
    }

    function rewardsManager_claimRewardReferenceEmitting(uint256 epochId, address vault, address token, address user) public asActor {
        rewardsManager.claimRewardReferenceEmitting(epochId, vault, token, user);
    }

    function rewardsManager_claimRewards(uint256[] memory epochsToClaim, address[] memory vaults, address[] memory tokens, address[] memory users) public asActor {
        rewardsManager.claimRewards(epochsToClaim, vaults, tokens, users);
    }

    function rewardsManager_notifyTransfer(address from, address to, uint256 amount) public asActor {
        rewardsManager.notifyTransfer(from, to, amount);
    }

    function rewardsManager_reap(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.reap(params);
    }

    function rewardsManager_tear(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.tear(params);
    }
}