use starknet::ContractAddress;

//in this interface all functions are external
#[starknet::interface]
pub trait ILQTYStaking<TContractState> {
    fn setAddresses(ref self: TContractState,
        _lqty_token_address: ContractAddress,
        _bold_token_address: ContractAddress,
        _trove_manager_address:ContractAddress,
        _borrower_operations_address: ContractAddress,
        _active_pool_address: ContractAddress);

    fn stake(ref self: TContractState, _LQTY_amount: u256);

    fn unstake(ref self: TContractState, _LQTY_amount: u256);

    fn increase_F_ETH(ref self: TContractState, _ETH_Fee: u256);

    fn increase_F_bold(ref self: TContractState, _LQTY_Fee: u256);

    fn get_pending_ETH_gain(self: @TContractState, _user: ContractAddress) -> u256;

    fn get_pending_bold_gain(self: @TContractState, _user: ContractAddress) -> u256;

    // this is the only time that it is used.
}