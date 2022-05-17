// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lec4 {
    uint256 public a = 3;
    function changeA(uint256 _value) public returns(uint256){
        a =_value;
        return a;
    }
}
contract Public_example {
    uint256 public a = 3;
    
    function changeA(uint256 _value) public {
        a =_value;
    }
    function get_a() view public returns (uint256)  {
        return a;
    }
}

contract Public_example_2 {
    
    Public_example instance = new Public_example();

    function changeA_2(uint256 _value) public{
      instance.changeA(_value);
    }
    function use_public_example_a() view public returns (uint256)  {
        return instance.get_a();
    }
}
contract View_example{
     uint256 public a = 1;
    
    function read_a() public view returns(uint256){
        return a+2;
    } 
}