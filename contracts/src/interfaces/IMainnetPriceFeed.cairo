//use interfaces::IPriceFeed;
use dependencies::AggregatorV3Interface;

#[derive(Drop)]
enum PriceSource {
    Primary,
    ETHUSDxCanonical,
    LastGoodPrice
}


#[starknet::interface]
pub trait IMainnetPriceFeed<TContractState> {
    fn eth_usd_oracle(self: @TContractState) -> (AggregatorV3Interface, u256, u8);
    fn price_source(self: @TContractState) -> PriceSource;
}
//------------------------------------------------
//changes from solidity and other noted
//------------------------------------------------
//this interface supposed to use also the IPriceFeed interface,
//but in cairo it doesn't possible
//so don't forget in the implementation to import and use also IPriceFeed!
//------------------------------------------------
//implementation and references
//------------------------------------------------
//the priceFeed of the other LST's implements it.
//the main usage is in mainnetPriceFeedBase

//I didn't see any implementation of the functions in the project
//maybe the functions are implemented in the external contracts of the priceFeed service
//I didn't see usage in the project, I think that the only use is in the tests.



