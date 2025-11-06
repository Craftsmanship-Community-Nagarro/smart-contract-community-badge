// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * Session-Host-Badge (ERC-1155, Token-ID = 1)
 * - Nur Rolle COMMUNITY_LEAD darf vergeben/entziehen
 * - Transfers zwischen Usern sind deaktiviert (soulbound-ähnlich)
 */
contract CommunityBadge is ERC1155, AccessControl {
    bytes32 public constant COMMUNITY_LEAD = keccak256("COMMUNITY_LEAD");
    uint256 public constant SESSION_HOST = 1;

    constructor(string memory baseUri) ERC1155(baseUri) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(COMMUNITY_LEAD, msg.sender);
    }
    
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function award(address to) external onlyRole(COMMUNITY_LEAD) {
        _mint(to, SESSION_HOST, 1, "");
    }

    function revoke(address from) external onlyRole(COMMUNITY_LEAD) {
        _burn(from, SESSION_HOST, 1);
    }

    // nicht übertragbar
    function safeTransferFrom(address, address, uint256, uint256, bytes memory) public pure override {
        revert("Badges are non-transferable");
    }
    function safeBatchTransferFrom(address, address, uint256[] memory, uint256[] memory, bytes memory) public pure override {
        revert("Badges are non-transferable");
    }
}