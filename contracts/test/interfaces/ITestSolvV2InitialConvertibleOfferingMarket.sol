// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.
    (c) Enzyme Council <council@enzyme.finance>
    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

/// @title ITestSolvV2InitialConvertibleOfferingMarket Interface
/// @author Enzyme Council <security@enzyme.finance>
/// @notice A test interface for Solv V2 Initial Convertible Offering Market
interface ITestSolvV2InitialConvertibleOfferingMarket {
    event Traded(
        address indexed buyer,
        uint24 indexed offeringId,
        address indexed voucher,
        uint256 voucherId,
        uint24 tradeId,
        uint32 tradeTime,
        address currency,
        uint8 priceType,
        uint128 price,
        uint128 tradedUnits,
        uint256 tradedAmount,
        uint128 fee
    );

    struct MintParameter {
        uint128 lowestPrice;
        uint128 highestPrice;
        uint128 tokenInAmount;
        uint64 effectiveTime;
        uint64 maturity;
    }

    struct Offering {
        uint24 offeringId;
        uint32 startTime;
        uint32 endTime;
        PriceType priceType;
        uint128 totalUnits;
        uint128 units;
        uint128 min;
        uint128 max;
        address voucher;
        address currency;
        address issuer;
        bool useAllowList;
        bool isValid;
    }

    enum PriceType {
        FIXED,
        DECLIINING_BY_TIME
    }

    function addAllowAddress(
        address _voucher,
        address[] calldata _addresses,
        bool _resetExisting
    ) external;

    function buy(uint24 _offeringId, uint128 _units)
        external
        returns (uint256 amount_, uint128 fee_);

    function mintParameters(uint24 _offeringId)
        external
        view
        returns (MintParameter memory mintParameter_);

    function nextOfferingId() external returns (uint24 offeringId_);

    function offer(
        address _voucher,
        address _currency,
        uint128 _min,
        uint128 _max,
        uint32 _startTime,
        uint32 _endTime,
        bool _useAllowList,
        PriceType _priceType,
        bytes calldata _priceData,
        MintParameter calldata _mintParameter
    ) external returns (uint24 offeringId_);

    function offerings(uint24 _offeringId) external view returns (Offering memory offering_);

    function setVoucherManager(
        address _voucher,
        address[] calldata _managers,
        bool _resetExisting
    ) external;
}
