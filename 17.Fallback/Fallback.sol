// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;


contract Bank{
    event JustFallback(address _from,string message);
    event RecevieFallback(address _from,uint256 _value ,string message);
    event JustFallbackWIthFunds(address _from,uint256 _value ,string message);
    //~0.6 
//   function() external payable {
//      emit JustFallbackWIthFunds(msg.sender, msg.value,"JustFallback is called");
//     }
    
    
    //0.6~
    // fallback() external {
    //   emit JustFallback(msg.sender,"JustFallback is called");
    // }
    // receive() external payable {
    //   emit RecevieFallback(msg.sender, msg.value,"RecevieFallback is called");
    // }
    
    //
    fallback() external payable {
     emit JustFallbackWIthFunds(msg.sender, msg.value,"JustFallbackWIthFunds is called");
    }
  
}

contract You{

    //receve() 
    function DepositWithSend(address payable _to) public payable{
         bool success = _to.send(msg.value);
         require(success, "Failled" );
    }
    
    function DepositWithTransfer(address payable _to) public payable{
        _to.transfer(msg.value);
    }
    
    function DepositWithCall(address payable _to) public payable{
        // ~ 0.7
        // (bool sent, ) = _to.call.value(msg.value)("");
        // require(sent,"Failed to send either");
        
        //0.7 ~
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failled" );
    }
    
    //fallback()
    function JustGiveMessage(address payable _to) public payable{
        (bool success, ) = _to.call("HI");
        require(success, "Failled" );
    }
    
    //To the fallback() with Funds
    function JustGiveMessageWithFunds(address payable _to) public payable{
        (bool success,) = _to.call{value:msg.value}("HI");
        require(success, "Failled" );
    }
    
}