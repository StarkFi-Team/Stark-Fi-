use starknet::ContractAddress;
// in this project we dont use this interface
#[starknet::interface]
trait ICommunityIssuance<TContractState> {
    fn set_addresses(
        ref self: TContractState,
        _lqty_token_address: ContractAddress,
        _stability_pool_address: ContractAddress
    );

    fn issue_LQTY(ref self: TContractState) -> u256;

    fn send_LQTY(ref self: TContractState, account: ContractAddress, LQTY_amount: u256);
}
