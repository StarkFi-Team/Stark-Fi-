use starknet::ContractAddress;

#[starknet::interface]
trait IStaderOracle<TContractState> {
    fn exchangeRate(self :@TContractState) -> (u256, u256, u256);
}

//this dependency does not have any implementation in this project