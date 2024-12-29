use starknet::ContractAddress;
use array::Array;

#[derive(Copy, Clone, Drop)]
pub struct CombinedTroveData {
    id: u256,
    debt: u256,
    coll: u256,
    stake: u256,
    annual_InterestRate: u256,
    last_debt_updat_time: u256,
    last_interest_rate_adj_time: u256,
    interest_batch_manager: ContractAddress,
    batch_debt_shares: u256,
    batch_coll_shares: u256,
    snapshot_ETH: u256,
    snapshot_bold_debt: u256
}

#[derive(Copy, Clone, Drop)]
pub struct DebtPerInterestRate {
    interest_batch_manager: ContractAddress,        
    interest_rate: u256,
    debt: u256
}

//in this interface all functions are external
// #[starknet::interface]
pub trait IMultiTroveGetter<TContractState> {
    //_startIdx: i256 //
    fn get_multiple_sorted_troves(self: @TContractState, coll_index: u256, start_id_x: u256, count: u256) -> Array<CombinedTroveData>;

    fn get_debt_per_interest_rate_ascending(self: @TContractState, coll_index: u256, start_id: u256, max_iterations: u256) -> (Array<DebtPerInterestRate>, u256);
}

