// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CarbonCredits is Ownable {
    uint256 public totalRegistered;
    uint256 public verifierCount;
    uint256 public customerCount;

    struct CarbonCreditHolder {
        string name;
        uint256 id;
        uint256 holderId;
        uint256 creditsHeld;
        uint256 pricePerCredit;
        uint256 creditValidityPeriod;
        address payable addr;
    }

    struct Verifier {
        string name;
        string homeCountry;
        uint256 regNo;
        uint256 licenseNo;
        address addr;
        bool isExist;
    }

    struct Customer {
        string firstName;
        string lastName;
        string email;
        uint256 contact;
        uint256 id;
    }

    mapping(uint256 => CarbonCreditHolder) public creditHolders;
    mapping(uint256 => Verifier) public verifiers;
    mapping(uint256 => Customer) public customers;

    event NewCreditHolder(string name, uint256 holderId, uint256 creditsHeld, uint256 pricePerCredit, uint256 creditValidityPeriod, address indexed addr);

    function registerCreditHolder(string memory name, uint256 holderId, uint256 creditsHeld, uint256 pricePerCredit, uint256 creditValidityPeriod) public {
        totalRegistered++;
        creditHolders[totalRegistered] = CarbonCreditHolder(name, totalRegistered, holderId, creditsHeld, pricePerCredit, creditValidityPeriod, payable(msg.sender));
        emit NewCreditHolder(name, holderId, creditsHeld, pricePerCredit, creditValidityPeriod, msg.sender);
    }

    function registerVerifier(string memory name, string memory homeCountry, uint256 regNo, uint256 licenseNo) public {
        verifierCount++;
        require(verifiers[regNo].isExist == false, "Verifier already registered");
        verifiers[verifierCount] = Verifier(name, homeCountry, regNo, licenseNo, msg.sender, true);
    }

    function registerCustomer(string memory firstName, string memory lastName, string memory email, uint256 contact) public {
        customerCount++;
        customers[customerCount] = Customer(firstName, lastName, email, contact, customerCount);
    }

    function getVerifiers() public view returns (Verifier[] memory) {
        Verifier[] memory ret = new Verifier[](verifierCount);
        for (uint256 i = 0; i < verifierCount; i++) {
            ret[i] = verifiers[i + 1]; // Adjust index to start from 1
        }
        return ret;
    }

    function getCreditHolders() public view returns (CarbonCreditHolder[] memory) {
        CarbonCreditHolder[] memory ret = new CarbonCreditHolder[](totalRegistered);
        for (uint256 i = 0; i < totalRegistered; i++) {
            ret[i] = creditHolders[i + 1]; // Adjust index to start from 1
        }
        return ret;
    }

    function getCustomers() public view returns (Customer[] memory) {
        Customer[] memory result = new Customer[](customerCount);
        for (uint256 i = 0; i < customerCount; i++) {
            result[i] = customers[i + 1]; // Adjust index to start from 1
        }
        return result;
    }
}
