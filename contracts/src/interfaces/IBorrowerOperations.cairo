use starknet::ContractAddress;



use ILiquityBase;
use IAddRemoveManagers;
use IBoldToken;
use IPriceFeed;
use ISortedTroves;
use ITroveManager;
use IWETH;

#[derive(Copy, Drop)]
pub struct OpenTroveAndJoinInterestBatchManagerParams {
    owner: ContractAddress,
    ownerIndex: u256,
    collAmount: u256,
    boldAmount: u256,
    upperHint: u256,
    lowerHint: u256,
    interestBatchManager: ContractAddress,
    maxUpfrontFee: u256,
    addManager: ContractAddress,
    removeManager: ContractAddress,
    receiver: ContractAddress
}

#[derive(Copy, Drop)]
    // -- individual delegation --
    pub struct InterestIndividualDelegate {
        account: ContractAddress,
        minInterestRate: u128,
        maxInterestRate: u128,
        minInterestRateChangePeriod: u256,
   }
#[derive(Copy, Drop)]
       // -- batches --
       pub struct InterestBatchManager {
        minInterestRate: u128,
        maxInterestRate: u128,
        minInterestRateChangePeriod: u256
   }


// Common interface for the Borrower Operations.
#[starknet::interface]
trait IBorrowerOperations <TContractState>  {
    fn CCR (self: @TContractState) -> u256;
    fn MCR (self: @TContractState) -> u256;
    fn SCR (self: @TContractState) -> u256;

    fn openTrove(
         ref self:TContractState,
         _owner: ContractAddress,
         _ownerIndex: u256,
         _ETHAmount: u256,
         _boldAmount: u256,
         _upperHint: u256,
         _lowerHint: u256,
         _annualInterestRate: u256,
         _maxUpfrontFee: u256,
         _addManager: ContractAddress,
         _removeManager: ContractAddress,
         _receiver: ContractAddress
    )  -> u256;



    fn openTroveAndJoinInterestBatchManager(ref self:TContractState, OpenTroveAndJoinInterestBatchManagerParams calldata _params) -> u256;

    fn addColl(ref self:TContractState,  _troveId: u256, _ETHAmount: u256);

    fn withdrawColl(ref self:TContractState, _troveId: u256,  _amount: u256);

    fn withdrawBold(ref self:TContractState, _troveId: u256, _amount: u256, _maxUpfrontFee: u256);

    fn repayBold(ref self:TContractState, _troveId: u256,  _amount: u256);

    fn closeTrove(ref self:TContractState, _troveId: u256);

    fn adjustTrove(
        ref self:TContractState,
         _troveId: u256,
         _collChange: u256,
         _isCollIncrease: u256,
         _debtChange: u256,
         isDebtIncrease: bool,
         _maxUpfrontFee: u256
    );

    fn adjustZombieTrove(
         ref self:TContractState,
         _troveId: u256,
         _collChange: u256,
         _isCollIncrease:bool,
         _boldChange: u256,
         _isDebtIncrease: bool,
         _upperHint: u256,
         _lowerHint: u256,
         _maxUpfrontFee: u256
    );

    fn adjustTroveInterestRate(
         ref self:TContractState,
         _troveId: u256,
         _newAnnualInterestRate: u256,
         _upperHint: u256,
         _lowerHint: u256,
         _maxUpfrontFee: u256
    ) ;

    fn applyPendingDebt(ref self:TContractState, _troveId: u256, _lowerHint: u256, _upperHint: u256);

    fn onLiquidateTrove(ref self:TContractState, _troveId: u256);

    fn claimCollateral(ref self:TContractState);

    fn hasBeenShutDown(self:@TContractState) -> bool;
    fn shutdown(ref self:TContractState);
    fn shutdownFromOracleFailure(ref self:TContractState);

    fn checkBatchManagerExists(self:@TContractState,  _batchMananger: ContractAddress)  -> bool;


    fn getInterestIndividualDelegateOf(self:@TContractState,  _troveId: u256)
    //memory varibale
        -> InterestIndividualDelegate ;
    fn setInterestIndividualDelegate(
         ref self:TContractState,
         _troveId: u256,
         _delegate : ContracrAddress,
         _minInterestRate: u128,
         _maxInterestRate: u128,
        // only needed if trove was previously in a batch:
         _newAnnualInterestRate: u256,
         _upperHint: u256,
         _lowerHint: u256,
         _maxUpfrontFee: u256,
         _minInterestRateChangePeriod: u256
    );
    fn removeInterestIndividualDelegate(ref self:TContractState,  _troveId: u256);



    fn registerBatchManager(
        ref self:TContractState,
         minInterestRate: u128,
         maxInterestRate: u128,
         currentInterestRate: u128,
         fee: u128,
         minInterestRateChangePeriod: u128
    );
    fn lowerBatchManagementFee(ref self:TContractState, _newAnnualFee: u256);
    fn setBatchManagerAnnualInterestRate(
        ref self:TContractState,
         _newAnnualInterestRate: u128,
         _upperHint: u256,
         _lowerHint: u256,
         _maxUpfrontFee: u256
    );
    fn interestBatchManagerOf(self:@TContractState,  _troveId: u256)-> ContracrAddress;
    //return memory varibale
    fn getInterestBatchManager(self:@TContractState,  _account: ContracrAddress) -> InterestBatchManager;
    fn setInterestBatchManager(
        ref self:TContractState,
         _troveId: u256,
         _newBatchManager: ContractAddress,
         _upperHint: u256,
         _lowerHint: u256,
         _maxUpfrontFee: u256
    );
    fn removeFromBatch(
        ref self:TContractState,
         _troveId: u256,
         _newAnnualInterestRate: u256,
         _upperHint: u256,
         _lowerHint: u256,
         _maxUpfrontFee: u256
    );
    fn switchBatchManager(
        ref self:TContractState,
         _troveId: u256,
         _removeUpperHint: u256,
         _removeLowerHint: u256,
         _newBatchManager: ContractAddress,
         _addUpperHint: u256,
         _addLowerHint: u256,
         _maxUpfrontFee: u256
    ); 
}
// DeployLiquity2Script is import it, declare varibale of this type and also in AddressVars and calling function openTrove

// OpenTroves is import it, declare varibale of this type

// AddressesRegistry is declare varibale of this type

// IBorrowerOperations is import ,inherits and impliments

// GasPool is import and declare varibale of this  =_addressesRegistry.borrowerOperations();

// SortedTroves IBorrowerOperations is only import it but dont use

// TroveManager is declare varibale of this  =_addressesRegistry.borrowerOperations() and calling functions by it

//ITroveManager is import and returns in function
// function borrowerOperations() external view returns (IBorrowerOperations);

//MainnetPriceFeedBase is import and declare and borrowerOperations = IBorrowerOperations(_borrowOperationsAddress);

//BaseZapper is import and declare borrowerOperations = _addressesRegistry.borrowerOperations();

// GasCompZapper is declare varibale and calling function by it 



// LeverageLSTZapper is inheints GasCompZapper and use borrowOperation varible from it  calling functions by itthis varibale

// WETHZapper  is inheints GasCompZapper and use borrowOperation varible from it  calling functions by itthis varibale

// InterestBatchManagementTest and InterestIndividualDelegationTest  BaseTest TestDeployer InvariantsTestHandler SPinvariantsTestHandler TroveManagerTester IBorrowerOperationsTester ITroveManagerTester is test

//RebasingBatchShares is 

//SortedTroves is initialize addressVars.borrowerOperations

//BorrowerOperations is import inherits and test

// borrowOperation is address for borrow  on which many functions are invoked.

// in BorrowOpration we have to inhenits  ILiquityBase, IAddRemoveManagers because interface doesnt inheints othet interface