#[starknet::interface]
pub trait IStabilityPoolEvents<
    TContractState
> { //this interface has to include all the events of the StabilityPool contract.
//because we don't know now where to write the events- in a separate file or in the impl of the
//contract, I leave it empty in the meantime.
//we have another option- in this guide
//to check!
//https://docs.starknet.io/architecture-and-concepts/smart-contracts/starknet-events/

}
