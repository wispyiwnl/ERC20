// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "../src/ERC20.sol";

contract ERC20Deposit {
    ERC20 public token;

    constructor(address _token) {
        token = ERC20(_token);
    }

    function depositTokens(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(
            token.transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );
    }
}
