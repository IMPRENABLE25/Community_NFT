// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Nbasic} from "../src/Nbasic.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract NbasicTest is Test {
    Nbasic public nbasic;
    address owner = address(1);
    address user1 = address(2);
    address user2 = address(3);

    function setUp() public {
        vm.prank(owner);

        nbasic = new Nbasic("ipfs://bafkreigkaikw45dw4zoun343bpksjucuqdeljagare7n6nbbhmb46vuuoa/");
    }
    // Test que le propriétaire est bien celui qui a déployé le contrat
    function test_OwnerIsCorrect() public view {
        assertEq(nbasic.owner(), owner);
    }
    // On vérifie que pour n'importe quel ID,l'URI est le bon
    function test_UriIsCorrect() public view {
        string memory expectedUri = "ipfs://bafkreigkaikw45dw4zoun343bpksjucuqdeljagare7n6nbbhmb46vuuoa/";
        assertEq(nbasic.uri(0), expectedUri);
    }
    //Test de mint
    function testMintBatch() public {
        vm.prank(owner);
        address[] memory recipients = new address[](2);
        recipients[0] = user1;
        recipients[1] = user2;
        nbasic.mintBatch(recipients);
        assertEq(nbasic.balanceOf(user1, 0), 1);
        assertEq(nbasic.balanceOf(user2, 0), 1);
        assertEq(nbasic.getTotalMinted(), 2);
    }
    //Non Transferable test
    function test_NonTransferable() public {
        vm.prank(owner);
        address[] memory recipients = new address[](1);
        recipients[0] = user1;
        nbasic.mintBatch(recipients);
        vm.prank(user1);
        vm.expectRevert();
        nbasic.safeTransferFrom(user1, user2, 0, 1, "");
    }
    //Not the owner test
    function test_NotOwnerCannotMint() public {
        vm.prank(user1);
        address[] memory recipients = new address[](1);
        recipients[0] = user2;
        vm.expectRevert("Ownable: caller is not the owner");
        nbasic.mintBatch(recipients);
    }
    //Test de mint multiple fois au même utilisateur
    function test_MintToSameUserFails() public {
        vm.startPrank(owner);
        address[] memory recipients = new address[](1);
        recipients[0] = user1;
        nbasic.mintBatch(recipients);
        vm.expectRevert();
        nbasic.mintBatch(recipients);
        vm.stopPrank();
    }



 
}