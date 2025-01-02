use starknet::ContractAddress;
use openzeppelin::token::erc20::{ERC20Component, ERC20HooksEmptyImpl};
use contracts::interfaces::ITroveManager::{ITroveManagerDispatcherTrait, ITroveManagerDispatcher};


//TroveNFT we have to inhenits  IERC721Metadata because interface doesnt inheints other interface

#[starknet::interface]
pub trait ITroveNFT<TContractState> {
    fn mint(ref self: TContractState, owner: ContractAddress, trove_id: u256);
    fn burn(ref self: TContractState, trove_id: u256);
}

// the propuse of this interface:
// manages NFTs (non-fungible tokens) associated with a "Trove." Its functions include:
// Creating and deleting NFTs: Facilitating the minting and burning of NFTs linked to specific Troves.
// Ensuring the NFT serves as a unique identifier for the Trove and its owner: Guaranteeing that each NFT uniquely represents a Trove and its 
// associated owner, enabling precise tracking and management within the system.

//DeployLiquity2Script is  defines a variable of this type in the struct addressvars

//OpenTroves is import it define it  and use it in function transfer the nft
//function sweepTrove(ITroveNFT nft, uint256 troveId) external {
//     nft.transferFrom(address(this), msg.sender, troveId);

//AddressesRegistry is define a variable  and initialize it to address and emit

//TroveManager is import it, define a variable and calling function on it like mint

// AddRemoveManagers is import it, define a variable and initialize it to address use it in function

//IAddressesRegistry is import it, define a variable in thre struct AddressVars and return it from
//function  troveNFT() external view returns (ITroveNFT);

//ITroveManager is import it, return it from function  function troveNFT() external view returns
//(ITroveNFT);

//BaseTest is test

//Deployment declare in LiquityContractsDev and LiquityContracts struct and in
//LiquityContractAddresses is declare as address , deploy and initialize addresses.troveNFT =
//getAddress(
//address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)),
//SALT

//


