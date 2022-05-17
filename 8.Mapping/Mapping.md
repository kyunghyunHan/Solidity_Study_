# Mapping

- 기본적을 키-값 (key-value)저장소로,데이터를 저장하고 검색하는데 이용
- Mapping은 마치 어느 상자에 Key 를 넣어주면 Value 값 튀어 나온답니다.

```solidity
// 금융 앱용으로, 유저의 계좌 잔액을 보유하는 uint를 저장한다: 
mapping (address => uint) public accountBalance;
// 혹은 userID로 유저 이름을 저장/검색하는 데 매핑을 쓸 수도 있다 
mapping (uint => string) userIdToName;
```
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec17{
    mapping(uint256=>uint256) private ageList;
    
    
}
```
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;


contract lec17{
    mapping(string=>uint256) private priceList;
    mapping(uint256=>string) private nameList;
    mapping(uint256=>uint256) private ageList;
    
    
    function setAgeList(uint256 _index,uint256 _age) public {
        ageList[_index] = _age;
    }
    
    function getAge(uint256 _index) public view returns(uint256){
        return ageList[_index];
    }
    
}
```





## Msg.sender
- 현재 함수를 호출한 사람(혹은 스마트컨트렉트)의 주소를 가르키는 전역변수
- 컨트렉트는 누군가가 컨트렉트의 함수를 호출할떄 까지 블록체인상에서 아무것도 안함 항상msg.sender가 잇어야한다
- msg.sender를 활용하면 이더리움 블록체인의 보안성을 이용가능, 즉누군가 다른사람의 데이터를 변경하려면 해당 이더리움 주소와 관련된 키를 훔쳐야 가능
```solidity
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // `msg.sender`에 대해 `_myNumber`가 저장되도록 `favoriteNumber` 매핑을 업데이트한다 `
  favoriteNumber[msg.sender] = _myNumber;
  // ^ 데이터를 저장하는 구문은 배열로 데이터를 저장할 떄와 동일하다 
}

function whatIsMyNumber() public view returns (uint) {
  // sender의 주소에 저장된 값을 불러온다 
  // sender가 `setMyNumber`을 아직 호출하지 않았다면 반환값은 `0`이 될 것이다
  return favoriteNumber[msg.sender];
}
```

## Require
- 특정조건이 참이 아닐떄 함수가 여러 메세지를 발생하고, 실행을 멈추게 된다
```solidity
function sayHiToVitalik(string _name) public returns (string) {
  // _name이 "Vitalik"인지 비교한다. 참이 아닐 경우 에러 메시지를 발생하고 함수를 벗어난다
  // (참고: 솔리디티는 고유의 스트링 비교 기능을 가지고 있지 않기 때문에 
  // 스트링의 keccak256 해시값을 비교하여 스트링 값이 같은지 판단한다)
  require(keccak256(_name) == keccak256("Vitalik"));
  // 참이면 함수 실행을 진행한다:
  return "Hi!";
}
```
