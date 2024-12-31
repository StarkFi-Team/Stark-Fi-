//use interfaces::IPriceFeed;
use contracts::dependencies::AggregatorV3Interface::{AggregatorV3InterfaceDispatcher,AggregatorV3InterfaceDispatcherTrait};
#[derive(Drop, Serde, starknet::Store)]
enum PriceSource {
    // Determines where the PriceFeed sources data from. Possible states:
    Primary,              // - Uses the primary price calcuation, which depends on the specific feed
    ETHUSDxCanonical,     // - Uses Chainlink's ETH-USD multiplied by the LST' canonical rate
    LastGoodPrice         // - the last good price recorded by this PriceFeed.
}
#[starknet::interface]
pub trait IMainnetPriceFeed<TContractState> {
    fn eth_usd_oracle(self: @TContractState) -> (AggregatorV3InterfaceDispatcher, u256, u8);
    fn price_source(self: @TContractState) -> PriceSource;
}
//------------------------------------------------
//changes from solidity and other notes
//------------------------------------------------
//this interface supposed to use also the IPriceFeed interface,
//but in cairo it doesn't possible
//so don't forget in the implementation to import and use also IPriceFeed!
//------------------------------------------------
//implementation and references
//------------------------------------------------
//the priceFeed of the other LST's inherit it.
//the main usage is in mainnetPriceFeedBase that inherit
// in the mainnetPriceFeedBase also the PriceSource used 
// to inform what is the source of the priceFeed.
//I didn't see any implementation of the functions in the project
//maybe the functions are implemented in the external contracts of the priceFeed service
//I didn't see usage in the project, I think that the only use is in the tests.













