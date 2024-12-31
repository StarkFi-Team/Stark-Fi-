use starknet::ContractAddress;

// in this interface all functions are external
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

    fn burn(ref self: TContractState, account: ContractAddress, _amount: u256);

    fn send_to_pool(
        ref self: TContractState,
        sender: ContractAddress,
        poolAddress: ContractAddress,
        amount: u256
    );

    fn return_from_pool(
        ref self: TContractState, pool_address: ContractAddress, user: ContractAddress, amount: u256
    );
}
//
// @note
//
// ################################################################################################################################
// changes from solidity and other notes
// ################################################################################################################################
// this trait need to inherit IERC20Metadata, IERC20Permit, IERC5267
// because in cairo interface can't inherit another interfaces,
// so we need to inherit in impl this interface.
// and also import - use openzeppelin::token::erc20::IERC20Metadata; etc.
// ################################################################################################################################
//
//
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
//
// explain all functions in the interface.
//
//
//
// +++++++++ the propuse of this interface: +++++++++
//
//
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

