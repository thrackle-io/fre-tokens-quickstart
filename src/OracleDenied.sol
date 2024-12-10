// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/AccessControl.sol";
import {IOracleEvents} from "@thrackle-io/forte-rules-engine/src/common/IEvents.sol";

/**
 * @title Example On-chain Denied-List Oracle
 * @author @ShaneDuncan602, @oscarsernarosero, @TJ-Everett
 * @notice This is an example on-chain oracle that maintains a denied list.
 * @dev This is intended to be a model only. It stores the Denied list internally and returns bool true if address is in list.
 */
contract OracleDenied is AccessControl, IOracleEvents {

    bytes32 constant ORACLE_ADMIN_ROLE = keccak256("ORACLE_ADMIN_ROLE");
    
    mapping(address => bool) private deniedAddresses;

    /**
     * @dev Constructor that only serves the purpose of notifying the indexer of its creation via event
     */
    constructor(address _oracleAdmin) {
        emit AD1467_DeniedListOracleDeployed();
        _grantRole(ORACLE_ADMIN_ROLE, _oracleAdmin);
        _setRoleAdmin(ORACLE_ADMIN_ROLE, ORACLE_ADMIN_ROLE);
    }

    /**
     * @dev Return the contract name
     * @return name the name of the contract
     */
    function name() external pure returns (string memory) {
        return "Oracle - Denied List";
    }

    /**
     * @dev Add addresses to the denied list. Restricted to owner.
     * @param newDeniedAddrs the addresses to add
     */
    function addToDeniedList(address[] memory newDeniedAddrs) public onlyRole(ORACLE_ADMIN_ROLE) {
        for (uint256 i = 0; i < newDeniedAddrs.length; i++) {
            deniedAddresses[newDeniedAddrs[i]] = true;
        }
        emit AD1467_OracleListChanged(true, newDeniedAddrs);
    }

    /**
     * @dev Add single address to the denied list. Restricted to owner.
     * @param newDeniedAddr the addresses to add
     */
    function addAddressToDeniedList(address newDeniedAddr) public onlyRole(ORACLE_ADMIN_ROLE) {
        deniedAddresses[newDeniedAddr] = true;
        address[] memory addresses = new address[](1);
        addresses[0] =  newDeniedAddr;
        emit AD1467_OracleListChanged(true, addresses);
    }

    /**
     * @dev Remove addresses from the Denied list. Restricted to owner.
     * @param removeDeniedAddrs the addresses to remove
     */
    function removeFromDeniedList(address[] memory removeDeniedAddrs) public onlyRole(ORACLE_ADMIN_ROLE) {
        for (uint256 i = 0; i < removeDeniedAddrs.length; i++) {
            deniedAddresses[removeDeniedAddrs[i]] = false;
        }
        emit AD1467_OracleListChanged(false, removeDeniedAddrs);
    }

    /**
     * @dev Check to see if address is in denied list
     * @param addr the address to check
     * @return denied returns true if in the denied list, false if not.
     */
    function isDenied(address addr) public view returns (bool) {
        return deniedAddresses[addr];
    }

    /**
     * @dev Check to see if address is in denied list. Also emits events based on the results
     * @param addr the address to check
     * @return denied returns true if in the denied list, false if not.
     */
    function isDeniedVerbose(address addr) public returns (bool) {
        bool isAddressDenied = isDenied(addr);
        emit AD1467_DeniedAddress(addr, isAddressDenied);
        return isAddressDenied; 
    }
}
