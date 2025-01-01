use starknet::ContractAddress;

#[starknet::interface]
trait ILQTYToken<TContractState> {
    fn send_to_LQTY_staking(ref self: TContractState, sender: ContractAddress, amount: u256);

    fn get_deployment_start_time(self: @TContractState) -> u256;

    fn get_lp_rewards_entitlement(self: @TContractState) -> u256;
}
// @note
// ################################################################################################################################
// changes from solidity and other notes
// ################################################################################################################################
// this trait need to inherit IERC20, IERC20Permit.
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
//
// +++++++++ the propuse of this interface: +++++++++
//
// define the functionality of BOLD token
//
// --------------------------------------------------------------------------------------------------------------------------------
//
//
// ================================================================================================================================
// usage
// ================================================================================================================================
//
// this is the only time that it is used!
//
// ================================================================================================================================


