#[starknet::interface]
pub trait IInterestRouter<TContractState> {//
// Currently the Interest Router doesn’t need any specific function
}
//
// @audit-info
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
//
// the reason of using in empty interface:
// * an empty interface acts as a placeholder for future functionallity
//   making it easier to add functionallity.
// * an empty interface acts as a labal or category that marks which contracts or variables belong
//   to a specific group,
//   it is a way to ensure that you use the varibales correctly,
//   and will catch errors if you will try to use this type in unsuported variables or contracts.
// * using in empty interface makes it easier to swap imlemantations later.
// --------------------------------------------------------------------------------------------------------------------------------
//
//
// ================================================================================================================================
// usage
//
// * active_pool Contract
//   ^ create variable and initialize it in ctor.
//   ^ _mint_agg_interest function send it as address to mint boldToken.
// * addresses_registry Contract
//   ^ 
//   ^
// ================================================================================================================================


