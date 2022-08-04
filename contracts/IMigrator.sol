// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMigrator {

    function isMigrator(address candidate) external returns (bool);
    
    function addMigrator(address candidate) external;

    function deleteMigrator(address candidate) external;
    
}