// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact security@empowerx.io
contract EmpowerXToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    uint256 public constant MAX_SUPPLY = 5_400_000 * 10 ** 18;

    event PausedByOwner(address owner);
    event UnpausedByOwner(address owner);

    constructor(address initialOwner)
        ERC20("EmpowerX", "EMX")
        Ownable(initialOwner)
    {
        _mint(initialOwner, MAX_SUPPLY);
    }

    function pause() public onlyOwner {
        _pause();
        emit PausedByOwner(msg.sender);
    }

    function unpause() public onlyOwner {
        _unpause();
        emit UnpausedByOwner(msg.sender);
    }

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}
