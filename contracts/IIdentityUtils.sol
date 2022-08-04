// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IIdentityUtils {

    function isDeployer() external view returns (bool);

    function isDeployer(address account) external view returns (bool);

    function _identityContractAddr() external view returns (address);

    function _identityHandle() external view returns (string memory);
    
}