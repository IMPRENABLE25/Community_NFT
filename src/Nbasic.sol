// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Community NFT Contract
 * @dev This contract allows the owner to mint non-transferable NFTs to a list of addresses
 * @author Jonas Ayaovi
 *
 */
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Nbasic is ERC1155, Ownable {
    error NonTransferable();
    error InsufficientNumberOfTokens();
    error ArrayLengthMismatch();

    uint256 public totalMinted;
    string private _currentURI;
    event BadgeMinted(address indexed to, uint256 currentTotal);

    constructor(
        string memory initialURI
    ) ERC1155(initialURI) Ownable(msg.sender) {
        _currentURI = initialURI;
    }

    function setURI(string memory newuri) public onlyOwner {
        _currentURI = newuri;
    }

    function uri(uint256) public view override returns (string memory) {
        return _currentURI;
    }

    function mintBatch(address[] calldata to) public onlyOwner {
        if (to.length == 0) {
            revert InsufficientNumberOfTokens();
        }
        for (uint256 i = 0; i < to.length; i++) {
            if (balanceOf(to[i], 0) > 0) {
                revert ArrayLengthMismatch();
            }
            _mint(to[i], 0, 1, "");
            totalMinted += 1;
            emit BadgeMinted(to[i], totalMinted);
        }
    }

    //Rendre le token non transférable
    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override {
        if (from != address(0) && to != address(0)) {
            revert NonTransferable();
        }
        super._update(from, to, ids, values);
    }

    function getTotalMinted() public view returns (uint256) {
        return totalMinted;
    }

    function getAlreadyMinted(address user) public view returns (bool) {
        return balanceOf(user, 0) > 0;
    }
}
