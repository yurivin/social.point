// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./point-contracts/IIdentity.sol";

import "./IIdentityUtils.sol";
import "./UupsProxible.sol";


contract Migrator is UupsProxible {

    mapping(address => bool) public _migrator;
    
    IIdentityUtils _identityUtils;

    enum Action {
        INIT,
        ADD,
        DELETE
    }

    event ManageMigrator(Action, address author, address candidate, uint256 timestamp);

    function initialize(
        address candidateMigrator,
        address identityUtilsAddr
    ) public initializer onlyProxy {
        __Ownable_init();
        __UUPSUpgradeable_init();
        _identityUtils = IIdentityUtils(identityUtilsAddr);
        _migrator[candidateMigrator] = true;
        emit ManageMigrator(
            Action.INIT,
            msg.sender,
            candidateMigrator,
            block.timestamp
        );
    }

    function isMigrator(address candidate) public view returns (bool) {
        return _migrator[candidate];
    }
    
    function addMigrator(address candidate) external onlyOwner {
        _migrator[candidate] = true;
        emit ManageMigrator(
            Action.ADD,
            msg.sender,
            candidate,
            block.timestamp
        );
    }

    function deleteMigrator(address candidate) external onlyOwner {
        if(isMigrator(candidate)) {
            _migrator[candidate] = false;
            delete _migrator[candidate];
        }
        emit ManageMigrator(
            Action.DELETE,
            msg.sender,
            candidate,
            block.timestamp
        );
    }

    function _authorizeUpgrade(address) internal view override {
        require(
            IIdentity(_identityUtils._identityContractAddr()).isIdentityDeployer(
                _identityUtils._identityHandle(),
                msg.sender
            ),
            "You are not a deployer of this identity"
        );
    }
}