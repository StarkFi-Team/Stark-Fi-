use starknet::ContractAddress;
// in this project we dont use this interface
#[starknet::interface]
trait ICommunityIssuance<TContractState> {
    fn setAddresses(
        ref self: TContractState,
        _lqtyTokenAddress: ContractAddress,
        _stabilityPoolAddress: ContractAddress
    );

    fn issueLQTY(ref self: TContractState) -> u256;

    fn sendLQTY(ref self: TContractState, _account: ContractAddress, _LQTYamount: u256);
}
