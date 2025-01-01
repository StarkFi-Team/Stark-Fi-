use contracts::dependencies::AggregatorV3Interface::{
    AggregatorV3InterfaceDispatcher, AggregatorV3InterfaceDispatcherTrait
};


#[starknet::interface]
pub trait IWSTETHPriceFeed<TContractState> {
    fn stEth_usd_oracle(self: @TContractState) -> (AggregatorV3InterfaceDispatcher, u256, u8);
}
//exactly like the IRethPriceFeed...
//later I will update all of this description

//---------------------------------------------------
//changes from solidity and other notes
//---------------------------------------------------
//this interface supposed to use also the IMainnetPriceFeed trait
//but as we know it is not possible and hence we have to use it in the implementation.

//---------------------------------------------------
//implementations
//---------------------------------------------------
//again I don't see any implementations of the functions
//the wstETHPriceFeed contract inherits this interface but doesn't implement any function

//---------------------------------------------------
//access and visibility
//---------------------------------------------------
//the function is external view


