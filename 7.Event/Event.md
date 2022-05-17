# Event
- 이벤트는 컨트렉트가 블록체인 상에서 앱의 사용자 단에서 무언가 액션이 발생했을떄 의사소통하는 방법
- 예를 들면 송금하기 라는 함수가 있다고 가정했을 떄 송금하기 누르면 누르면 누른 사람의 계좌와 금액이 이벤트로 출력, 블록체인 네트워크에 기억
```solidity
// 이벤트를 선언한다
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public {
  uint result = _x + _y;
  // 이벤트를 실행하여 앱에게 add 함수가 실행되었음을 알린다:
  IntegersAdded(_x, _y, result);
  return result;
}
```
```solidity
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract lec13 {
   
    event info(string name, uint256 money);
    
    function sendMoney() public {
        emit info("KimDaeJin", 1000);
    }
}
```
- emit를 통해서 이벤트를 출력


## indexed
- indexed를 써줌으로써  블록들안에 출력된 이벤트들을 필터하여 저희가 원하는 이벤트만을 가지고 올 수 있다
```solidity
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract Lec14 {
    event numberTracker(uint256 indexed num, string str);

    uint256 num =0;
    function PushEvent(string memory _str) public {
        emit numberTracker(num,_str);
        num ++;
    }
}
```
