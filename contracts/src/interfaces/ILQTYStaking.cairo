use starknet::ContractAddress;

//in this interface all functions are external
#[starknet::interface]
pub trait ILQTYStaking<TContractState> {
    fn set_addresses(
        ref self: TContractState,
        lqty_token_address: ContractAddress,
        bold_token_address: ContractAddress,
        trove_manager_address: ContractAddress,
        borrower_operations_address: ContractAddress,
        active_pool_address: ContractAddress
    );

    fn stake(ref self: TContractState, _LQTY_amount: u256);

    fn unstake(ref self: TContractState, _LQTY_amount: u256);

    fn increase_F_ETH(ref self: TContractState, _ETH_Fee: u256);

    fn increase_F_bold(ref self: TContractState, _LQTY_Fee: u256);

    fn get_pending_ETH_gain(self: @TContractState, _user: ContractAddress) -> u256;

    fn get_pending_bold_gain(self: @TContractState, _user: ContractAddress) -> u256;
}
//
// @audit-info
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
// * fn set_addresses():
//   initialization function, sets up connections to other key contracts in the system:
//   -lqty_token_address - LQTY token contract
//   -bold_token_address - BOLD token contract
//   -trove_manager_address - manages Troves (collateralized debt positions)
//   -borrower_operations_address - handles borrower operations
//   -active_pool_address - manages active collateral and debt
//
// * fn stake():
//   users deposit LQTY tokens into the staking contract ->
//      1.starts earning rewards (ETH fees and BOLD tokens).
//      2.updates user's stake in the system.
//      3.tracks time of stake for reward calculations.
//
// * fn unstake():
//   users withdraws LQTY tokens from staking ->
//      1.claims any pending rewards.
//      2.updates user's staking position.
//      3.reduces future reward earnings.
//
// * fn increase_F_ETH():
//   called when system collects ETH fees.
//   distributes ETH rewards to stakers.
//   updates cumulative fee per token.
//
// * increase_F_bold():
//   similar to increase_F_ETH() but with BOLD.
//
// * get_pending_ETH_gain():
//   calculates pending ETH rewards for a user base on:
//      1.user's stake amount.
//      2.time staked.
//      3.total system fees collected.
//      4.overall size of pull staking.
//
// * get_pending_bold_gain():
//   similar to get_pending_ETH_gain but for BOLD tokens.
//
//
// +++++++++ the propuse of this interface: +++++++++
//
// users can stake their LQTY tokens to earn passive income from the protocol's operation by this
// interface.
//
// --------------------------------------------------------------------------------------------------------------------------------
//
//
//
// ================================================================================================================================
// usage
// ================================================================================================================================
//
// this is the only time that it is used!
//
// ================================================================================================================================


