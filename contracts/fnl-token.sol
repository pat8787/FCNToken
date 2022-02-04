pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract FictionalCoin is ERC20, Ownable {
    uint256 public constant INITIAL_SUPPLY = 200_000_000 * 1 ether;
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 1 ether;

    constructor() ERC20("Fictional Coin", "FNL") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /**
     * Creates `amount` of new tokens for Owner.
     */

    function fictionalMint(uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "FNL amount must be lower than or equal to MAX_SUPPLY");
        _mint(msg.sender, amount);
    }
}
