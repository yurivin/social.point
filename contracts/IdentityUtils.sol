// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IIdentityUtils.sol";
import "./UupsProxible.sol";

import "./point-contracts/IIdentity.sol";

contract IdentityUtils is IIdentityUtils, UupsProxible {

    address public override _identityContractAddr;
    string public override _identityHandle;

    function isDeployer() override external view returns (bool) {
        return isDeployer(msg.sender);
    }

    function isDeployer(address account) override public view returns (bool) {
        return IIdentity(_identityContractAddr).isIdentityDeployer(_identityHandle, account);
    }

    function initialize(
        address identityContractAddr,
        string calldata identityHandle
    ) external initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
        _identityContractAddr = identityContractAddr;
        _identityHandle = identityHandle;
    }

      function _authorizeUpgrade(address) internal view override {
        require(
            IIdentity(_identityContractAddr).isIdentityDeployer(
                _identityHandle,
                msg.sender
            ),
            "You are not a deployer of this identity"
        );
    }
}
