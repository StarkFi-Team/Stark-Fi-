use contracts::dependencies::AggregatorV3Interface::{
    AggregatorV3InterfaceDispatcher, AggregatorV3InterfaceDispatcherTrait
};

#[starknet::interface]
pub trait IRETHPriceFeed<TContractState> {
    fn rEth_Eth_oracle(self: @TContractState) -> (AggregatorV3InterfaceDispatcher, u256, u8);
}
//---------------------------------------------------
//changes from solidity and other notes
//---------------------------------------------------
//this interface supposed to use also the IMainnetPriceFeed trait
//but as we know it is not possible and hence we have to use it in the implementation.

//---------------------------------------------------
//implementations
//---------------------------------------------------
//I don't see any implementations of the function
//the rETHPriceFeed contract inherits this interface but doesn't implement any function

//---------------------------------------------------
//access and visibility
//---------------------------------------------------
//the function is external view


