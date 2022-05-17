// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec17{
    mapping(uint256=>uint256) private ageList;
    
    
    function setAgeList(uint256 _index,uint256 _age) public {
        ageList[_index] = _age;
    }
    
    function getAge(uint256 _index) public view returns(uint256){
        return ageList[_index];
    }
  
    
}