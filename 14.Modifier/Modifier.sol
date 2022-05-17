// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lec27{
    
    modifier onlyAdults{
         revert("You are not allowed to pay for the cigarette");
         _;
    }
  
    // function BuyCigarette() public onlyAdults returns(string memory){
    //     return "Your payment is scceeded";
    // }   
    
}