// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./point-contracts/IIdentity.sol";

import "./IMigrator.sol";
import "./IIdentityUtils.sol";
import "./Migratable.sol";
import "./UupsProxible.sol";


contract SocialProfile is Migratable, UupsProxible {

    struct Profile {
        bytes32 displayName;
        bytes32 displayLocation;
        bytes32 displayAbout;
        bytes32 avatar;
        bytes32 banner;
    }

    IIdentityUtils public _identityUtils;

    mapping(address => Profile) public profileByOwner;

    event ProfileChange(address indexed from, uint256 indexed date);

    function setProfile(
        bytes32 name_,
        bytes32 location_,
        bytes32 about_,
        bytes32 avatar_,
        bytes32 banner_
    ) external {
        profileByOwner[msg.sender].displayName = name_;
        profileByOwner[msg.sender].displayLocation = location_;
        profileByOwner[msg.sender].displayAbout = about_;
        profileByOwner[msg.sender].avatar = avatar_;
        profileByOwner[msg.sender].banner = banner_;
        emit ProfileChange(msg.sender, block.timestamp);
    }

    function getProfile(address id_) external view returns (Profile memory) {
        return profileByOwner[id_];
    }

    // Data Migrator Functions - only callable by _migrator
     function addProfile(
        address user,
        bytes32 name,
        bytes32 location,
        bytes32 about,
        bytes32 avatar,
        bytes32 banner
    ) public onlyMigrator {

        profileByOwner[user].displayName = name;
        profileByOwner[user].displayLocation = location;
        profileByOwner[user].displayAbout = about;
        profileByOwner[user].avatar = avatar;
        profileByOwner[user].banner = banner;

        emit ProfileChange(user, block.timestamp);
    }

    function initialize(
        address identityUtilsAddr,
        address migratorAddr
    ) public initializer onlyProxy {
        __Ownable_init();
        __UUPSUpgradeable_init();
        _identityUtils = IIdentityUtils(identityUtilsAddr);
        _migrator = IMigrator(migratorAddr);
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