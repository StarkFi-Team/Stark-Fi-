


//IActivepool uses this inteface - in this function 
//function stabilityPool() external view returns (IBoldRewardsReceiver); 

//IStabilitypool inherits it

//active pool


interface IBoldRewardsReceiver {
    function triggerBoldRewards(uint256 _boldYield) external;
}