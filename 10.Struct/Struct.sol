// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec20{
    struct Character{
        uint256 age;
        string name;
        string job;
    }
    

    function createCharacter(uint256 _age,string memory _name,string memory _job) public pure{
        Character(_age,_name,_job);
    }
    
 
}