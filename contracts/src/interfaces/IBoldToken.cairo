use starknet::ContractAddress;

#[starknet::interface]
trait IBoldToken<TContractState> {
    fn set_branch_addresses(
        ref self: TContractState,
        trove_manager_address: ContractAddress,
        stability_pool_address: ContractAddress,
        borrower_operations_address: ContractAddress,
        active_pool_address: ContractAddress
    );

    fn set_collateral_registry(
        ref self: TContractState, collateral_registry_address: ContractAddress
    );

    fn mint(ref self: TContractState, account: ContractAddress, amount: u256);

    fn burn(ref self: TContractState, account: ContractAddress, amount: u256);

    fn send_to_pool(
        ref self: TContractState,
        sender: ContractAddress,
        pool_address: ContractAddress,
        amount: u256
    );

    fn return_from_pool(
        ref self: TContractState, pool_address: ContractAddress, user: ContractAddress, amount: u256
    );
}
// @note
// ################################################################################################################################
// changes from solidity and other notes
// ################################################################################################################################
// this trait need to inherit IERC20Metadata, IERC20Permit, IERC5267
// because in cairo interface can't inherit another interfaces,
// so we need to inherit in impl this interface.
// and also import - use openzeppelin::token::erc20::IERC20Metadata; etc.
//
// in this interface all functions are external
//
// ################################################################################################################################
//
//
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
//
// * fn set_branch_addresses():
//   sets the core protocol contract addresses, define which contracts can interact with the token:
//   - trove_manager_address
//   - stability_pool_address
//   - borrower_operations_address
//   - active_pool_address
//
// * fn set_collateral_registry():
//   used for multi-collateral management:
//    this function receives the address of collateral_registry contract and sets up which collateral
//    types can be used against BOLD token.
//   this function called at initialize of this system and only by the owner.
//
// * fn mint():
//   create new BOLD tokens.
//
// * fn burn():
//   destroys existing BOLD tokens.
//
// * fn send_to_pool():
//   moves BOLD tokens from a user to a protocol pool. used when:
//   - users deposit BOLD to StabilityPool for earning rewards.
//   - during liquidation processes.
//
// * fn return_from_pool():
//   moves BOLD tokens from a protocol pool to a user. used when:
//   - Users withdraw their BOLD from the StabilityPool deposits.
//   - during liquidation processes.
//
// +++++++++ the propuse of this interface: +++++++++
//
// define the functionality of BOLD token.
//
// --------------------------------------------------------------------------------------------------------------------------------
//
//
// ================================================================================================================================
// usage
// ================================================================================================================================
//
// ------contracts-------
//
//
// ------interfaces-------
//
//
// ================================================================================================================================


