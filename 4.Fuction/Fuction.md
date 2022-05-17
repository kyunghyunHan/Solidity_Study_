# Fuctionn
- 함수 인자명을 언더스코어 시작해서 전역변수와 구별하는것이 관례
```solidity
function eatHamburgers(string _name, uint _amount) {

}
//다음과 같이 호출
eatHamburgers("vitalik", 100);
```
## 1. Parameter 와 Retrun 값이 없는 function 정의
```
 function 이름 () public { // (public, private, internal, external) 변경가능.  
      // 내용
    }
```
## 2. Parameter는 있고, Retrun 값이 없는 function 정의
```
    function 이름 (받고싶은 타입  변수명 ) public { 
      // 내용
    }
ex) 
    function 이름 (uint 256 _value) public { 
      // 내용
    }
```
## 3. Parameter는 있고, Retrun 값이 있는 function 정의
```
function 이름 (받고싶은 타입  변수명 ) public returns(반환하고자 하는 type) {
      // 내용
    }
ex) 
    function 이름 (uint 256 _value) public returns(uint256) { 
      // 내용
    }

```

## public :어디서든 접근 가능
- 기본적인 함수를 private로 선언하고 공개할 함수만 public으로 선언
```solidity
contract Lec5 {
    uint256 public a = 3;
}
```

## private: 오직 private이 정의된 스마트 컨트랙에서만 접근가능 

## external : 오직 밖에서만 접근 가능. 
- external이기에, external이 정의된 스마트 컨트랙 내에서는 사용이 불가능 
- 함수가 컨트렉트 바깥에서만 호출될수 있고 컨트렉트 내의 다른 함수에 의해 호출될수 없다는 점을 제외하면 public과 동일

## internal : 오직 internal이 정의된 스마트 컨트랙 내에서, 상속받은 자식 스마트 컨트랙에서 접근 가능.
```solidity
contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string) {
    baconSandwichesEaten++;
    // eat 함수가 internal로 선언되었기 때문에 여기서 호출이 가능하다 
    eat();
  }
}
```
- internal 은 private 과 비슷해요, private에서 한가지 기능(상속받은 자식 접근 가능)이 더 추가 되었다고 생각하시면 됩니다.
- 함수가 정의된 컨트렉트를 상속하는 컨트렉트 에서도 접근이 가능하는 점을제외하면 private와동일

## 정리
- public: 모든곳에서 접근 가능
- external: public 처럼 모든곳에서 접근 가능하나, external이 정의된 자기자신 컨트랙 내에서 접근 불가
 
- private: 오직 private이 정의된 자기 컨트랙에서만 가능( private이 정의된 컨트랙을 상속 받은 자식도 불가능)
- internal: private 처럼 오직 internal 이 정의된 자기 컨트랙에서만 가능하고, internal이 정의된 컨트랙을 상속받은 자식들도 접근이 가능

## view
- storage state 를 읽을 수 있지만, 그 state 값을 변경할 수 없다.
```solidity
function sayHello() public view returns (string) {
  ```
## pure 

- storage state 를 읽으면 안되고, 그 state값을 변경할 수 도 없다.
```solidity
function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}
```
## 반환값
- 반환값:함수에서 어떤 값을 반환 받으려면 다음과 같이 선언
```solidity
string greeting = "What's up dog";

function sayHello() public returns (string) {
  return greeting;
}
```

## 인터페이스
- 블록체인상에 있으면서 우리가 소유하지 않은 컨트렉트와 우리컨트렉트가 상호작용 하려면 인터페이스 정의
- 컨트렉트 정의와 유사
- 다른 컨트렉트와 상호작용 하는 함수만을 선언할뿐
- 함수 몸체를 정의하지 않는다
```solidity
아래와 같이 인터페이스가 정의되면
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}

다음과 같이 컨트랙트에서 인터페이스를 이용할 수 있지:
contract MyContract {
  address NumberInterfaceAddress = 0xab38...
  // ^ 이더리움상의 FavoriteNumber 컨트랙트 주소이다
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress)
  // 이제 `numberContract`는 다른 컨트랙트를 가리키고 있다.

  function someFunction() public {
    // 이제 `numberContract`가 가리키고 있는 컨트랙트에서 `getNum` 함수를 호출할 수 있다:
    uint num = numberContract.getNum(msg.sender);
    // ...그리고 여기서 `num`으로 무언가를 할 수 있다
  }
}
```

## 다수의 반환값 처리
```solidity
function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}

function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // 다음과 같이 다수 값을 할당한다:
  (a, b, c) = multipleReturns();
}

// 혹은 단 하나의 값에만 관심이 있을 경우: 
function getLastReturnValue() external {
  uint c;
  // 다른 필드는 빈칸으로 놓기만 하면 된다: 
  (,,c) = multipleReturns();
}
```
## View함수를 이용헤 절역
- view 함수는 사용자의 의해 외부에서 호출되었을 때 가스를 전혀 소모하지 않는다
- view 함수가 블록체인 상에서 어떤 것도 수정하지 않기 때문 데이터읽기
- 가능한 external view함수를 쓰는것 (가스 사용 최적화)
## Storage는 비싸다
- solidity에서 비싼 연산중 하나인 storage를 쓰는것 그중에서도 쓰기연산
- 데이터의 일부를 쓰거나 바꿀때마다 블록체인에 영구적으로 기록되기 때문
- 비용을 최소화하기 위해 진짜 필요한 경우 아니면 storage에 데이터를 쓰지 않는 것이 좋음
- Storage보다는 memory사용해서 함수끝날때까지만 사용 (가스절약)
```solidity
function getArray() external pure returns(uint[]) {
  // 메모리에 길이 3의 새로운 배열을 생성한다.
  uint[] memory values = new uint[](3);
  // 여기에 특정한 값들을 넣는다.
  values.push(1);
  values.push(2);
  values.push(3);
  // 해당 배열을 반환한다.
  return values;
}
```