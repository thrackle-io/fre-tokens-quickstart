// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@thrackle-io/forte-rules-engine/src/client/token/IProtocolToken.sol";
import "@thrackle-io/forte-rules-engine/src/client/token/IProtocolTokenHandler.sol";
import {IZeroAddressError} from "@thrackle-io/forte-rules-engine/src/common/IErrors.sol";
import {ITokenEvents, IApplicationEvents} from "@thrackle-io/forte-rules-engine/src/common/IEvents.sol";

/**
 * @title Example ERC20 QuickstartERC20
 * @author @ShaneDuncan602, @oscarsernarosero, @TJ-Everett, @Palmerg4
 * @notice This is an example implementation that App Devs should use.
 * @dev During deployment _tokenName _tokenSymbol _tokenAdmin are set in constructor
 */
contract QuickstartERC20 is
    ERC20,
    AccessControl,
    IProtocolToken,
    IZeroAddressError,
    ReentrancyGuard,
    ITokenEvents,
    IApplicationEvents
{
    bytes32 constant TOKEN_ADMIN_ROLE = keccak256("TOKEN_ADMIN_ROLE");

    address private handlerAddress;

    /**
     * @dev Constructor sets params
     * @param _name Name of the token
     * @param _symbol Symbol of the token
     * @param _tokenAdmin Token Admin address
     */
    // slither-disable-next-line shadowing-local
    constructor(
        string memory _name,
        string memory _symbol,
        address _tokenAdmin
    ) ERC20(_name, _symbol) {
        _grantRole(TOKEN_ADMIN_ROLE, _tokenAdmin);
        _setRoleAdmin(TOKEN_ADMIN_ROLE, TOKEN_ADMIN_ROLE);
    }

    /**
     * @dev Function mints new tokens.
     * @param to recipient address
     * @param amount number of tokens to mint
     */
    function mint(
        address to,
        uint256 amount
    ) public onlyRole(TOKEN_ADMIN_ROLE) {
        _mint(to, amount);
    }

    /**
     * @dev Function called before any token transfers to confirm transfer is within rules of the protocol
     * @param from sender address
     * @param to recipient address
     * @param amount number of tokens to be transferred
     */
    // slither-disable-next-line calls-loop
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        /// Rule Processor Module Check
        if (handlerAddress != address(0))
            require(
                IProtocolTokenHandler(handlerAddress).checkAllRules(
                    balanceOf(from),
                    balanceOf(to),
                    from,
                    to,
                    _msgSender(),
                    amount
                )
            );
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev This function returns the handler address
     * @return handlerAddress
     */
    function getHandlerAddress() external view override returns (address) {
        return handlerAddress;
    }

    /**
     * @dev Function to connect Token to previously deployed Handler contract
     * @param _deployedHandlerAddress address of the currently deployed Handler Address
     */
    function connectHandlerToToken(
        address _deployedHandlerAddress
    ) external override onlyRole(TOKEN_ADMIN_ROLE) {
        if (_deployedHandlerAddress == address(0)) revert ZeroAddress();
        handlerAddress = _deployedHandlerAddress;
        emit AD1467_HandlerConnected(_deployedHandlerAddress, address(this));
    }
}
