// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";

// ghost variables for tracking state variable values before and after function calls
abstract contract BeforeAfter is Setup {
    struct Vars {
        uint256 unused;
    }

    Vars internal _before;
    Vars internal _after;

    function __before() internal {

    }

    function __after() internal {

    }

    modifier updateGhosts {
        __before();
        _;
        __after();
    }
}
