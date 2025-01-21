// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20} from "../src/ERC20.sol";

contract ERC20Test is Test {
    ERC20 public erc20;

    string public name;
    string public symbol;

    address owner = makeAddr("owner");
    address to = makeAddr("to");
    address to1 = makeAddr("to1");
    address spender = makeAddr("spender");

    uint8 public decimals;
    uint8 amount = 5;
    uint8 amount1 = 1;
    uint256 spenderAmount = 100;
    uint256 public totalSupply;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event TokenMinted(address indexed _to, uint256 _amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function setUp() public {
        vm.prank(owner);
        erc20 = new ERC20("WISPY", "WP");
    }

    function test_getters() public view {
        console.log("Function name:", erc20._name());
        console.log("Function owner:", erc20._owner());
        console.log("Function symbol:", erc20._symbol());
        console.log("Function decimals:", erc20._decimals());
        console.log("Function totalSupply:", erc20._totalSupply());
        console.log("Function balanceOf:", erc20._balanceOf(owner));
    }

    function test_mint() public {
        vm.startPrank(owner);

        erc20.mint(owner, 555);
        assertEq(erc20.balanceOf(owner), 555);

        vm.stopPrank();
    }

    function test_transfer() public {
        vm.startPrank(owner);

        erc20.mint(owner, 555);
        assertEq(erc20.balanceOf(owner), 555);

        erc20.approve(spender, spenderAmount);

        uint256 _allownace = erc20._allowance(owner, spender);
        console.log("Allowance: ", _allownace);

        vm.expectEmit();
        emit Transfer(owner, spender, spenderAmount);
        erc20.transferFrom(owner, spender, spenderAmount);

        assertEq(erc20.balanceOf(owner), 455);
        assertEq(erc20.balanceOf(spender), spenderAmount);
        vm.stopPrank();
    }
}
