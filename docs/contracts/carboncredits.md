# CarbonCredits Contract Explanation

The `CarbonCredits` contract manages the registration and tracking of carbon credits, verifiers, and customers.

## Data Structures

The contract uses three main structs:

*   **`CarbonCreditHolder`:** Stores information about holders of carbon credits, including their name, ID, credits held, price per credit, and validity period.
*   **`Verifier`:** Stores information about verifiers, including their name, home country, registration number, and license number.
*   **`Customer`:** Stores information about customers, including their name, email, and contact information.

## Mappings

The contract uses mappings to store data for each registered entity:

*   `creditHolders`: Maps credit holder IDs to `CarbonCreditHolder` structs.
*   `verifiers`: Maps verifier IDs to `Verifier` structs.
*   `customers`: Maps customer IDs to `Customer` structs.

## Functions

The contract provides functions for:

*   **`registerCreditHolder`:** Registers a new carbon credit holder.
*   **`registerVerifier`:** Registers a new verifier.
*   **`registerCustomer`:** Registers a new customer.
*   **`getVerifiers`:** Retrieves an array of all registered verifiers.
*   **`getCreditHolders`:** Retrieves an array of all registered credit holders.
*   **`getCustomers`:** Retrieves an array of all registered customers.

## Events

The contract emits a `NewCreditHolder` event whenever a new credit holder is registered.

## Important Considerations

*   The contract uses `Ownable` for access control.  Only the contract owner can modify certain aspects of the contract.
*   Error handling is minimal.  More robust error handling should be added for production use.
*   The contract does not include functionality for transferring carbon credits.  This should be added for a complete system.

This document provides a high-level overview of the `CarbonCredits` contract.  Refer to the contract's source code for detailed implementation specifics.
