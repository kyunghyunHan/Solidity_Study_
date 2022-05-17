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
- uint256으로 인자를 받음
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
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lec4 {
    uint256 public a = 3;
    function changeA(uint256 _value) public returns(uint256){
        a =_value;
        return a;
    }
}
```
- _value의 인자값을 받고
- a 값 리턴 (uint256)

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

```solidity
contract external_example {
    uint256 private a = 3;
    
    function get_a() view external returns (uint256)  {
        return a;
    }

}

contract external_example_2 {
    
    external_example instance = new external_example();

    function external_example_get_a() view public returns (uint256)  {
        return instance.get_a();
    }
}
```
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
```solidity
pragma solidity >=0.7.0 <0.9.0;

contract View_example{
     uint256 public a = 1;
    
    function read_a() public view returns(uint256){
        return a+2;
    } 
}
```
- 만약 read_a에서 stroage state값을 바꾼다면 아무것도 안써주면 댄다

## pure 

- storage state 를 읽으면 안되고, 그 state값을 변경할 수 도 없다.
```solidity
function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}
```
## 정리 
- view : function 밖의 변수들을 읽을수 있으나 변경 불가능
- pure : function 밖의 변수들을 읽지 못하고, 변경도 불가능
- viwe 와 pure 둘다 명시 안할때: function 밖의 변수들을 읽어서, 변경을 해야함.
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

## Storage vs Memory
- Stotage는 블록체인상에 영구적으로 저장되는 변수
- Memory는 임시적으로 저장되는 변수, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 삭제
- 상태변수는(함수 외부에 선언된 변수) 는 초기설정상 storage로 선언, 블록체인에 영구적으로 저장되며, 함수 내부의 memory로 자동 선언 되어서 함수 호출이 되면 사라짐
- Colldata:주로 external function의 파라메타로 사용
- stack:EVM(Ethereum Virtual Machine)에서 stack data를 관리할떄 쓰는 영역(1024mb제한)
```solidity
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ 꽤 간단해 보이나, 솔리디티는 여기서 
    // `storage`나 `memory`를 명시적으로 선언해야 한다는 경고 메시지를 발생한다. 
    // 그러므로 `storage` 키워드를 활용하여 다음과 같이 선언해야 한다:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...이 경우, `mySandwich`는 저장된 `sandwiches[_index]`를 가리키는 포인터이다.
    // 그리고 
    mySandwich.status = "Eaten!";
    // ...이 코드는 블록체인 상에서 `sandwiches[_index]`을 영구적으로 변경한다. 

    // 단순히 복사를 하고자 한다면 `memory`를 이용하면 된다: 
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...이 경우, `anotherSandwich`는 단순히 메모리에 데이터를 복사하는 것이 된다. 
    // 그리고 
    anotherSandwich.status = "Eaten!";
    // ...이 코드는 임시 변수인 `anotherSandwich`를 변경하는 것으로 
    // `sandwiches[_index + 1]`에는 아무런 영향을 끼치지 않는다. 그러나 다음과 같이 코드를 작성할 수 있다: 
    sandwiches[_index + 1] = anotherSandwich;
    // ...이는 임시 변경한 내용을 블록체인 저장소에 저장하고자 하는 경우이다.
  }
}
```

## 반환
```solidity
    function add2(uint256 _num1, uint256 _num2) public pure returns (uint256 total){
         total = _num1 + _num2;
         return total;
    }
```