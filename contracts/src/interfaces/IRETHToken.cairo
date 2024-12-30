
#[starknet::interface]
pub trait IRETHToken<TContractState> {
    //the function is external and view
    fn get_exchange_rate(self: @TContractState) -> u256;
}
//used just in in one place- RETHPriceFeed, there tries to access to rateProviderAddress
//if the contract implement the interface and has this function- implement it
//otherwise, I don't know, we will see it there...


