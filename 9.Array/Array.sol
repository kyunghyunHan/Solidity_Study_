// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
 
contract lec18{
    
    
    uint256[] public ageArray; 
    
    function AgeLength()public view returns(uint256) {
        return ageArray.length;
    }
    
    
}