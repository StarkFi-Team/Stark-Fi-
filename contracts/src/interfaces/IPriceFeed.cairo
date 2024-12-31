use starknet::ContractAddress;
#[starknet::interface]
pub trait IPriceFeed<TContractState> {
    fn fetch_price(self: @TContractState) -> (u256, bool);
    fn fetch_redemption_price(self: @TContractState) -> (u256, bool);
    fn last_good_price(self: @TContractState) -> u256;
    fn set_addresses(ref self: TContractState, _borrow_operations_address: ContractAddress);
}
//the interface of price feed of each branch implements this interface
//all functions are external


