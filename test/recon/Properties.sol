// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {
    // Solvency on rewards

    // Soundness of math


    function canary_totalSupply_atEpoch() public {
        (uint256 totalSupply, ) = rewardsManager.getTotalSupplyAtEpoch(rewardsManager.currentEpoch(), address(this));
        eq(totalSupply, 0, "Total supply is less than 0");
    }

    // Soundneed of total supply
    function solvency_totalSupply_atEpoch() public {
        (uint256 totalSupply, ) = rewardsManager.getTotalSupplyAtEpoch(rewardsManager.currentEpoch(), address(this));

        uint256 totalBalances;
        address[] memory users = _getActors();
        for(uint256 i = 0; i < users.length; i++) {
            (uint256 balance, ) = rewardsManager.getBalanceAtEpoch(rewardsManager.currentEpoch(), address(this), users[i]);
            totalBalances += balance;
        }

        gte(totalSupply, totalBalances, "Total supply is less than total balances");
    }
}
