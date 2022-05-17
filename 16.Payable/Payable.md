# Payable
- 이더를 받을수 있는 함수
```solidity
contract OnlineStore {
  function buySomething() external payable {
    // 함수 실행에 0.001이더가 보내졌는지 확실히 하기 위해 확인:
    require(msg.value == 0.001 ether);
    // 보내졌다면, 함수를 호출한 자에게 디지털 아이템을 전달하기 위한 내용 구성:
    transferThing(msg.sender);
  }
}
```
- msg.value는 컨트렉트로 이더가 얼마나 보내졌는지 확인하는 방법
- ether은 기존적으로 포함된 단위
- value는 봉투안에 현금을 넣는것과 같음 - 편지와 돈이 모두 수령인에게 전달

## 출금
```solidity
contract GetPaid is Ownable {
  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }
}
```
- transfer함수를 사용해서 이더를 특정주소로 전달
- this.balance는 컨트랙트에 저장되어 있는 전체 잔액을 반환
- 100명이 사용자가 컨트렉트의 1이더를 지불했다면 this.balance는 100ether
```solidity
uint itemFee = 0.001 ether;
msg.sender.transfer(msg.value - itemFee);
```
## msg.value
- 송금보낸 코인의 값

## 이더를 보내는 3가지방법
- send:2300gas소리, 성공여부를 true또는 false로 리턴
- transfer:2300gas소비, 실패시 에러발생
- call:가변적인 gas소비(gas값 지정 가능),성공여부 true 또는 false로 리턴(2019년 이후 call사용을 추천)
```solidity
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
}​
```

## balance 
- 현재 이더의 잔액

## msg.sender
- 컨트렉트와 상호작용
- call vs delegate call에서 주요 내용

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract MobileBanking{
    
 
    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(address _msgSender, address _to,uint256 _value);
   
    function sendEther(address payable _to) public payable {
        require(msg.sender.balance>=msg.value, "Your balance is not enough");
        _to.transfer(msg.value);    
        emit SendInfo(msg.sender,(msg.sender).balance);
    }
    
    function checkValueNow() public{
        emit MyCurrentValue(msg.sender, msg.sender.balance);
    }
    
    function checkUserMoney(address _to) public{
        emit CurrentValueOfSomeone(msg.sender,_to ,_to.balance);
    }
    
}
```

## msg.sender 함수 사용에 권한 제헌
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract MobileBanking{
    
    address owner;
    constructor() payable{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner, "Only Owner!");
        _;
    }
    
    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(address _msgSender, address _to,uint256 _value);
   
    function sendEther(address payable _to) public onlyOwner payable {
       
        require(msg.sender.balance>=msg.value, "Your balance is not enough");
        _to.transfer(msg.value);    
        emit SendInfo(msg.sender,(msg.sender).balance);
    }
    
    function checkValueNow() public onlyOwner {
        emit MyCurrentValue(msg.sender, msg.sender.balance);
    }
    
    function checkUserMoney(address _to) public onlyOwner {
        emit CurrentValueOfSomeone(msg.sender,_to ,_to.balance);
    }
    
}
```