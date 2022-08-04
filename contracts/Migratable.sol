// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IMigrator.sol";

abstract contract Migratable {

    IMigrator public _migrator;

    modifier onlyMigrator {
        require(_migrator.isMigrator(msg.sender), "Access Denied");
        _;
    }
}