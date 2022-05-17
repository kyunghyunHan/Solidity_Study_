# Library
- 기존에 만들던 스마트컨트랙과 다른종류의 스마트컨트렉
- 재사용:블록체인에 라이브러리가 배포되면 다른 스마트컨트렉트에 적용가능
- 가스소비 줄임:라이브러리는 재사용 가능 한 코드, 즉 여러개의 스마트컨트렉에서 공통의로 쓰이는 코드를 따로 라이브러리통해서 배포하기에, 다른 스마트컨트렉에 명시를 해주는 것이 아니라 라이브러리를 적용만 하면 되기에 가스 소비량을 줄일수 있다.
- 데이터 타입 적용:라이브러리 기능들은 데이터타입에 적용가능, 쉽게 사용가능

## 제한사항
- fallback함수 를 라이브러리 안에 정의 불가능 이더를 가질수 업다,
- 상속 불가
- payble함수 정의 불가

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

library SafeMath{
    function add(uint8 a, uint8 b) internal pure returns (uint8) {
        require(a+b >= a , "SafeMath: addition overflow");
        return a + b;
    }
}

contract lec40{
    using SafeMath for uint8;
    uint8 public a; 
    
    function becomeOverflow(uint8 _num1,uint8 _num2) public  {
       // a = _num1.add(_num2);
        a = SafeMath.add(_num1 ,_num2);
       
    } 
}
```