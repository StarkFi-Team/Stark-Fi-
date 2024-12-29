#[starknet::interface]
pub trait IInterestRouter<TContractState> {//
// Currently the Interest Router doesn’t need any specific function
}
//
//
// --------------------------------------------------------------------------------------------------------------------------------
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
// where and why IInterestRouter interface used?
// * active_pool Contract
//
//
//
//
// ================================================================================================================================


