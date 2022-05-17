# 1.HelloWorld
- // SPDX-License-Identifier: GPL-3.0 : 이 라이센스는 무조건 맨위에 명시 해주셔야 에러가 나지 않습니다.
- pragma solidity >=0.7.0 <0.9.0; : 솔리디티의 컴파일 버전 명시 입니다 ( 즉 0.7 ~0.9 의 버전을 사용)
- contract Hello{ : 스마트 컨트랙 명시 입니다. 
 - string public hi = "Hello solidity";  : hi 라는 public 함수에 hello solidity 를 넣었습니다. 
0 }
## 컨트랙트 
- 컨트랙트는 이더리움 애플리케이션의 기본적인 구성 요소로, 모든 변수와 함수는 어느 한 컨트랙트에 속하게 마련. 컨트랙트는 모든 프로젝트의 시작 지점
## 상태변수 
- 상태변수는 컨트렉트 저장소에 영구적으로 저장
- uint 자료형은 부호 없는 정수
```solidity
contract Example {
  // 이 변수는 블록체인에 영구적으로 저장된다
  uint myUnsignedInteger = 100;
}
```