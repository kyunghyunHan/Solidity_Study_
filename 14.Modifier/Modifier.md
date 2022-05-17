# Modifier
```solidity
// 파라미터 값이 없는 경우   
   modifier 모디파이어명{
         revert 나 require
         _;
    }
 
 // 파라미터 값이 없는 경우
    modifier 모디파이어명(파라미터){
          revert 나 require
         _;
    }
```
## 파라미터가 있는 modifier 경우
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lec27{

    modifier onlyAdults2(uint256 _age){
         require(_age>18,"You are not allowed to pay for the cigarette");
         _;
    }

    function BuyCigarette2(uint256 _age) public onlyAdults2(_age) returns(string memory){
        return "Your payment is scceeded";
    }
  
}
```

## 소유가능한 컨트렉트
```solidity
/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}
```
- 생성자(Constructor): function Ownable()는 생성자이네. 컨트랙트와 동일한 이름을 가진,생략할 수 있는 특별한 함수. 이 함수는 컨트랙트가 생성될 때 딱 한 번만 실행.
- 함수 제어자(Function Modifier): modifier onlyOwner(). 제어자는 다른 함수들에 대한 접근을 제어하기 위해 사용되는 일종의 유사 함수. 보통 함수 실행 전의 요구사항 충족 여부를 확인하는 데에 사용. onlyOwner의 경우에는 접근을 제한해서 오직 컨트랙트의 소유자만 해당 함수를 실행할 수 있도록 하기 위해 사용될 수 있다.

## modifier
```solidity
/**
 * @dev Throws if called by any account other than the owner.
 */
modifier onlyOwner() {
  require(msg.sender == owner);
  _;
}
//다음과 같이 사용

contract MyContract is Ownable {
  event LaughManiacally(string laughter);

  // 아래 `onlyOwner`의 사용 방법
  function likeABoss() external onlyOwner {
    LaughManiacally("Muahahahaha");
  }
}
```
## 함수제어자의 또다른 특징
- 함수제어자는 인수또한 받을수 있음
```solidity
// 사용자의 나이를 저장하기 위한 매핑
mapping (uint => uint) public age;

// 사용자가 특정 나이 이상인지 확인하는 제어자
modifier olderThan(uint _age, uint _userId) {
  require (age[_userId] >= _age);
  _;
}

// 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
// `olderThan` 제어자를 인수와 함께 호출하려면 이렇게 하면 되네:
function driveCar(uint _userId) public olderThan(16, _userId) {
  // 필요한 함수 내용들
}
```
```solidity
// 사용자의 나이를 저장하기 위한 매핑
mapping (uint => uint) public age;

// 사용자가 특정 나이 이상인지 확인하는 제어자
modifier olderThan(uint _age, uint _userId) {
  require (age[_userId] >= _age);
  _;
}

// 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
function driveCar(uint _userId) public olderThan(16, _userId) {
  // 필요한 함수 내용들
}
```
