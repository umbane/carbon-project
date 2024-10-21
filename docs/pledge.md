# Pledge Contract Explanation

The `Pledge` contract manages pledges made using MJ and AC tokens.  It allows users to create pledges, fulfill them, and potentially allocate a portion of generated tokens to projects.  This contract inherits from the `Token` contract, which is assumed to define the MJ and AC tokens.

## Key Features

*   **Pledge Creation:** Users can create pledges using `createPledge`, specifying the recipient (`_pledgee`), amounts of MJ and AC tokens, and the amount of CarB tokens to be generated.
*   **Token Burning:** Upon pledge creation, the specified MJ and AC tokens are burned from the pledger's balance.
*   **Pledge Fulfillment:**  The `fulfillPledge` function allows the pledger to fulfill the pledge, minting CarB tokens to the pledgee.
*   **CarB Token Generation:** The amount of CarB tokens generated is calculated based on a formula (currently a placeholder).
*   **Project Allocation (Placeholder):** The `allocateToProject` function is a placeholder for allocating CarB tokens to projects.  This requires further implementation and considerations for project verification and governance.

## Data Structures

*   `pledges`: A mapping from pledger addresses to `PledgeDetails` structs.
*   `PledgeDetails`: A struct containing pledge details: pledgee address, amounts of MJ and AC tokens pledged, CarB tokens generated, and a boolean indicating fulfillment status.

## Functions

*   `createPledge`: Creates a new pledge.
*   `fulfillPledge`: Fulfills an existing pledge, minting CarB tokens to the pledgee.
*   `allocateToProject`: A placeholder function for allocating CarB tokens to projects.

## Events

*   `PledgeCreated`: Emitted when a pledge is created.
*   `PledgeFulfilled`: Emitted when a pledge is fulfilled.

## Important Considerations

*   The `Token` contract is crucial for understanding the token mechanics.
*   The CarB token generation formula needs to be refined based on the specific requirements.
*   The `allocateToProject` function requires significant further development to include project verification and governance mechanisms.
*   Error handling and input validation should be improved for production use.

This document provides a high-level overview of the `Pledge` contract.  Refer to the contract's source code and the `Token` contract for detailed implementation specifics.
