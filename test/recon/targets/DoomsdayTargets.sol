// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

abstract contract DoomsdayTargets is
    BaseTargetFunctions,
    Properties
{
    
    function claim_rewards_never_reverts() public stateless {
        uint256 epochId = rewardsManager.currentEpoch() - 1;
        rewardsManager.claimRewardEmitting(epochId, address(this), _getAsset(), _getActor());
    }
}