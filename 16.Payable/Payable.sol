// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract lec32 {
    
    event howMuch(uint256 _value);
    function sendNow(address payable _to) public payable{
        bool sent = _to.send(msg.value); // return true or false
        require(sent,"Failed to send either");
        emit howMuch(msg.value);
    }
    
    function transferNow(address payable _to) public payable{
        _to.transfer(msg.value);
        emit howMuch(msg.value);
    }
    
    function callNow (address payable _to) public payable{
        //0.50
        // (bool sent, ) = _to.call.gas(1000).value(msg.value)("");
        // require(sent,"Failed to send either");
        
        //0.7 ~
        (bool sent, ) = _to.call{value: msg.value , gas:1000}("");
        require(sent, "Failed to send Ether");
        emit howMuch(msg.value);
    }
}