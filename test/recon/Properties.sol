// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {
    // Solvency on rewards
    // Since users are the only one that can have balances


    // Soundness of math


    function canary_totalSupply_atEpoch() public {
        (uint256 totalSupply, ) = rewardsManager.getTotalSupplyAtEpoch(rewardsManager.currentEpoch(), address(this));
        eq(totalSupply, 0, "Total supply is less than 0");
    }

    // Soundneed of total supply
    // Since users are the only one that can have non-zero balance this is now a strict check
    function solvency_totalSupply_atEpoch() public {
        (uint256 totalSupply, ) = rewardsManager.getTotalSupplyAtEpoch(rewardsManager.currentEpoch(), address(this));

        uint256 totalBalances;
        address[] memory users = _getActors();
        for(uint256 i = 0; i < users.length; i++) {
            (uint256 balance, ) = rewardsManager.getBalanceAtEpoch(rewardsManager.currentEpoch(), address(this), users[i]);
            totalBalances += balance;
        }

        eq(totalSupply, totalBalances, "Total supply is not equal to total balances");
    }

    // Internals
    // At the current epoch, my balance matches the balance in storage

    // Internals
    // If my balance at epoch is non zero, then my time MUST be non-zero
    // NOTE: Inductive
    function solvency_balance_atEpoch_nonZero() public {
        uint256 shares = rewardsManager.shares(rewardsManager.currentEpoch(), address(this), _getActor());
        if(shares > 0) {
            uint256 time = rewardsManager.lastUserAccrueTimestamp(rewardsManager.currentEpoch(), address(this), _getActor());
            gt(time, 0, "Time must be set");
        }
    }

    // DOOMSDAY
    function doomsday_accrual_logic_is_sound() public stateless {
        // Accrue all users
        address[] memory users = _getActors();
        for(uint256 i = 0; i < users.length; i++) {
            rewardsManager.accrueUser(rewardsManager.currentEpoch(), address(this), users[i]);
        }

        // If I accrued all users, then getBalanceAtEpoch matches shares
        uint256 totalShares;
        for(uint256 i = 0; i < users.length; i++) {
            (uint256 balance, ) = rewardsManager.getBalanceAtEpoch(rewardsManager.currentEpoch(), address(this), users[i]);
            uint256 shares = rewardsManager.shares(rewardsManager.currentEpoch(), address(this), users[i]);
            totalShares += shares;
            eq(balance, shares, "Balance is not equal to shares");
        }

        // If I accrued all users, then getTotalSupplyAtEpoch matches shares
        (uint256 totalSupply, ) = rewardsManager.getTotalSupplyAtEpoch(rewardsManager.currentEpoch(), address(this));
        eq(totalSupply, totalShares, "Total supply is not equal to total shares");
    }

    // NOTE: Inductive
    function doomsday_sum_of_claims() public stateless {
        uint256 epochId = rewardsManager.currentEpoch() - 1;
        address[] memory users = _getActors();

        uint256 rewardsForEpoch = rewardsManager.rewards(epochId, address(this), _getAsset());

        for(uint256 i = 0; i < users.length; i++) {
            uint256 pointsWithdrawn = rewardsManager.pointsWithdrawn(epochId, address(this), users[i], _getAsset());
            require(pointsWithdrawn == 0, "Points withdrawn is not 0"); // Must be zero so we can check delta balances
        }

        // Claim rewards for all users, sum delta balances
        uint256 totalDeltaBalances;
        for(uint256 i = 0; i < users.length; i++) {
            rewardsManager.claimRewardEmitting(epochId, address(this), _getAsset(), users[i]);
            (uint256 balance, ) = rewardsManager.getBalanceAtEpoch(rewardsManager.currentEpoch(), address(this), users[i]);
            totalDeltaBalances += balance;
        }

        eq(totalDeltaBalances, rewardsForEpoch, "Total delta balances is not equal to rewards for epoch");
    }
}
