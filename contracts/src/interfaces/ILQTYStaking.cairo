use starknet::ContractAddress;

//in this interface all functions are external
#[starknet::interface]
pub trait ILQTYStaking<TContractState> {
    fn setAddresses(ref self: TContractState,
        _lqtyTokenAddress: ContractAddress,
        _boldTokenAddress: ContractAddress,
        _troveManagerAddress:ContractAddress,
        _borrowerOperationsAddress: ContractAddress,
        _activePoolAddress: ContractAddress);

    fn stake(ref self: TContractState, _LQTYamount: u256);

    fn unstake(ref self: TContractState, _LQTYamount: u256);

    fn increaseF_ETH(ref self: TContractState, _ETHFee: u256);

    fn increaseF_bold(ref self: TContractState, _LQTYFee: u256);

    fn getPendingETHGain(self: @TContractState, _user: ContractAddress) -> u256;

    fn getPendingBoldGain(self: @TContractState, _user: ContractAddress) -> u256;

    // this is the only time that it is used.
}