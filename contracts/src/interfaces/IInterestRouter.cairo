#[starknet::interface]
pub trait IInterestRouter<TContractState> { //
// Currently the Interest Router doesn’t need any specific function
}
// @note
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
// the reason of using in empty interface:
// * an empty interface acts as a placeholder for future functionallity
//   making it easier to add functionallity.
// * an empty interface acts as a labal or category that marks which contracts or variables belong
//   to a specific group,
//   it is a way to ensure that you use the varibales correctly,
//   and will catch errors if you will try to use this type in unsuported variables or contracts.
// * using in empty interface makes it easier to swap imlemantations later.
//
//
// +++++++++ the propuse of this interface: +++++++++
//
// - handle all the logic related to interest distribution
//  * check for LPs that eligible for rewards.
//  * manages distribution ratios.
//  * handles the actual token distribution to LPs based on: Provided liquidity, time in the pool,
//  share of the pool.
// --------------------------------------------------------------------------------------------------------------------------------
//
//
//
// ================================================================================================================================
// usage
// ================================================================================================================================
//
// ------contracts-------
//
// * active_pool Contract:
//   ^ create variable and initialize it in ctor.
//   ^ _mint_agg_interest function - handles minting of BOLD tokens for interest payments and fees
//     this function send the bold_token that minted to this address(IInterestRouter).
//
// * addresses_registry Contract:
//   ^ create varibale called interest_router of IInterestRouter type use it in:
//   ^ set_addresses() function - initalize the variable in AddressVars struct.
//   ^ emit interest_router_address_changed(address(_vars.interest_router));
//
// * mock_interest_router Contract:
//   ^ contract is inheriting from the IInterestRouter.
//   -- mock uses for testing
//
// * deploy_liquity_2_script Contract
//   ^ LiquityContractsTestnet struct - create variable of IInterestRouter type.
//   ^ DeploymentVarsTestnet struct create a variable call contract of LiquityContractsTestnet type.
//   ^ (LiquityContractAddresses struct - create interest_router variable of address type).
//   ^ _deploy_and_connect_collateral_contracts_testnet function: contracts.interest_router =
//     IInterestRouter(compute_governance_Aaddress(deployer, SALT, _boldToken, new address[](0)));
//     casting the address from compute_governance_Aaddress function to IInterestRouter type.
//   ^ initialize interest_router variable in AddressVars struct in IAddressesRegistry.
//
// * base_test contract
//   ^ import and create variable call mock_interest_router of IInterestRouter type.
//
// ------interfaces-------
//
// * IActivePool interface
//   ^ create function interest_router() that returns variable of IInterestRouter type.
//
// * IAddressesRegistry interface
//   ^ AddressVars struct - create variable of IInterestRouter type.
//   ^ create function interest_router() that returns variable of IInterestRouter type.
//
// ================================================================================================================================


