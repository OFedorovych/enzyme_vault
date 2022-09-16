// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Council <council@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.6.12;

/// @title ITestCurveAddressProvider interface
/// @author Enzyme Council <security@enzyme.finance>
interface ITestCurveAddressProvider {
    function get_address(uint256 _id) external view returns (address address_);

    function get_registry() external view returns (address registry_);
}
