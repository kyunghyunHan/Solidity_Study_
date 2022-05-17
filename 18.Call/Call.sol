// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract add{
    event JustFallback(string _str);
    function addNumber(uint256 _num1, uint256 _num2) public pure returns(uint256){
        return _num1 + _num2;
    }
    fallback() external {
     emit JustFallback("JustFallback is called");
    }
}

contract caller{
    event calledFunction(bool _success, bytes _output);
   
    //1. 송금하기 
    function transferEther(address payable _to) public payable{
        (bool success,) = _to.call{value:msg.value}("");
        require(success,"failed to transfer ether");
    }
    
    //2. 외부 스마트 컨트랙 함수 부르기 
    function callMethod(address _contractAddr,uint256 _num1, uint256 _num2) public{
        (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call(
              abi.encodeWithSignature("addNumber2(uint256,uint256)",_num1,_num2)
              );
        require(success,"failed to transfer ether");
        emit calledFunction(success,outputFromCalledFunction);
    }
}