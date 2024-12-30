use starknet::ContractAddress;
use array::Array;

#[derive(Copy, Clone, Drop)]
pub struct CombinedTroveData {
    id: u256,
    debt: u256,
    coll: u256,
    stake: u256,
    annual_interest_rate: u256,
    last_debt_update_time: u256,
    last_interest_rate_adj_time: u256,
    interest_batch_manager: ContractAddress,
    batch_debt_shares: u256,
    batch_coll_shares: u256,
    snapshot_ETH: u256,
    snapshot_bold_debt: u256
}

#[derive(Copy, Clone, Drop)]
pub struct DebtPerInterestRate {
    interest_batch_manager: ContractAddress,
    interest_rate: u256,
    debt: u256
}

//in this interface all functions are external
// #[starknet::interface]
pub trait IMultiTroveGetter<TContractState> {
    //_startIdx: i256 //
    fn get_multiple_sorted_troves(
        self: @TContractState, coll_index: u256, start_id_x: u256, count: u256
    ) -> Array<CombinedTroveData>;

    fn get_debt_per_interest_rate_ascending(
        self: @TContractState, coll_index: u256, start_id: u256, max_iterations: u256
    ) -> (Array<DebtPerInterestRate>, u256);
}
//
// @audit-info
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
// 
// * CombinedTroveData struct:
//   this structure stores ALL information about a single loan (Trove).
//   id: u256,                                // Unique identifier for each loan
//   debt: u256,                              // Amount borrowed
//   coll: u256,                              // Collateral amount locked
//   stake: u256,                             // Amount staked in the system
//   annual_interest_rate: u256,              // Yearly interest rate
//   last_debt_update_time: u256,             // When debt was last updated
//   last_interest_rate_adj_time: u256,       // When interest rate was last changed
//   interest_batch_manager: ContractAddress, // Contract managing interest
//   batch_debt_shares: u256,                 // Share of debt in the batch
//   batch_coll_shares: u256,                 // Share of collateral in the batch
//   snapshot_ETH: u256,                      // ETH snapshot value
//   snapshot_bold_debt: u256                 // BOLD debt snapshot
//
// * DebtPerInterestRate struct:
//   this tracks how much total debt exists at each interest rate.
//   interest_batch_manager: ContractAddress, // Who manages this interest rate
//   interest_rate: u256,                     // The actual interest rate
//   debt: u256                               // Total debt at this rate
//
// * fn get_multiple_sorted_troves():
//   gets information about multiple loans at the same time.
//   returns them in sorted order
//   you tell it where to start and how many to get
//   variables:
//   coll_index: u256,         // Which type of collateral to look at
//   start_id_x: u256,         // Which ID to start from
//   count: u256               // How many Troves to get
//   Array<CombinedTroveData>  // Returns array of Trove information
//
// * fn get_debt_per_interest_rate_ascending():
//   shows how much debt exists at each interest rate
//   returns them in ascending order (lowest to highest rate)
//   also tells you total debt amount
//   variables:
//   start_id: u256,                     // Where to start
//   max_iterations: u256                // Maximum number to return
//   (Array<DebtPerInterestRate>, u256)  // Returns debts grouped by interest rate
//
// Think of it like:
// first function: "Show me the next 10 loans in the system"
// second function: "Show me how much total debt we have at each interest rate"
//
//
// +++++++++ the propuse of this interface: +++++++++
//
// - handle all the logic related to interest distribution
//  * check for LPs that eligible for rewards.
//  * manages distribution ratios.
//  * handles the actual token distribution to LPs based on: Provided liquidity, time in the pool, share of the pool.
// --------------------------------------------------------------------------------------------------------------------------------
//
//
//
// ================================================================================================================================
// usage
// ================================================================================================================================
//
// ------contracts-------
//
// * addresses_registry Contract:
//   ^ create varibale called multi_trove_getter of IMultiTroveGetter type use it in:
//   ^ set_addresses() function - initalize the variable in AddressVars struct.
//   ^ emit multi_trove_getter_address_changed(address(_vars.multi_trove_getter));
//
// * multi_trove_getter Contract:
//   ^ import and inherit IMultiTroveGetter.
//
// * deploy_liquity_2_script Contract
//   ^ _deploy_and_connect_collateral_contracts_testnet() function:
//     It's a setup function that:
//     creates all the core contracts needed for the protocol to work
//     makes sure they can all communicate with each other
//     verifies everything is set up correctly
//     in this function:
//     get variable called multi_trove_getter and use it in this function to 
//     initialize multi_trove_getter variable in AddressVars struct in IAddressesRegistry.
//
// ------interfaces-------
//
// * IAddressesRegistry interface
//   ^ AddressVars struct - create variable of IMultiTroveGetter type.
//   ^ create function multi_trove_getter() that returns variable of IMultiTroveGetter type.
//
// ================================================================================================================================




