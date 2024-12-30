#[starknet::interface]
pub trait IInterestRouter<TContractState> { //
// Currently the Interest Router doesn’t need any specific function
}
//
// @audit-info
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
// --------------------------------------------------------------------------------------------------------------------------------
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
//   ^ _mint_agg_interest function send it as address to mint bold_token.
//
// * addresses_registry Contract:
//   ^ set_addresses() function initalize the variable in AddressVars struct.
//   ^ emit interest_router_address_changed(address(_vars.interest_router));
//
// * MockInterestRouter Contract:
//   ^ contract is inheriting from the IInterestRouter.
//   -- mock uses for testing
//
// * deploy_liquity_2_script Contract
//   ^ LiquityContractsTestnet struct - create variable of IInterestRouter type.
//   ^ DeploymentVarsTestnet struct create a variable call contract of LiquityContractsTestnet type.
//   ^ (LiquityContractAddresses struct - create interest_router variable of address type).
//   ^ _deploy_and_connect_collateral_contracts_testnet function: contracts.interestRouter =
//     IInterestRouter(computeGovernanceAddress(deployer, SALT, _boldToken, new address[](0)));
//   ^
// ------interfaces-------
//
// * IActivePool interface
//   ^ create function interestRouter() that returns variable of IInterestRouter type.
//
// * IAddressesRegistry interface
//   ^ AddressVars struct - create variable of of IInterestRouter type.
//   ^ create function interestRouter() that returns variable of IInterestRouter type.
//
// ================================================================================================================================


