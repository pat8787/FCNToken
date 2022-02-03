pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract FictionalToken is ERC20Burnable, Ownable {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 1 ether;
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 1 ether;
    uint256 public totalBurned = 0;

    constructor() ERC20("Fictional Token", "FCN") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function totalMinted() public view returns (uint256) {
        return totalSupply() + totalBurned;
    }

    /**
     * Creates `amount` of new tokens for Owner.
     */

    function fictionalMint(uint256 amount) external onlyOwner {
        require(totalMinted() + amount <= MAX_SUPPLY, "FCN amount must be lower than or equal to MAX_SUPPLY");
        _mint(msg.sender, amount);
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._afterTokenTransfer(from, to, amount);
        if (to == address(0)) {
        // if token is burned (sent to 0x address), add to totalBurned
            totalBurned = totalBurned + amount;
        }
    }
}
