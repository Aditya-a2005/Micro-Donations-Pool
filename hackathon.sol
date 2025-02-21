// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationPool {
    address public owner;  // Address of the charity
    uint256 public totalDonations;  // Tracks total funds donated

    // Set the owner when deployed
    function initializeOwner() public {
        require(owner == address(0), "Owner already set");
        owner = msg.sender;
    }

    // Automatically accepts donations without any input fields
    receive() external payable {
        totalDonations += msg.value;
    }

    // Function to allow only the charity (owner) to withdraw the funds
    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(address(this).balance > 0, "No funds available");
        
        payable(owner).transfer(address(this).balance);
    }

    // Check contract balance (optional view function)
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
