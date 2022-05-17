# Fuctionn
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
```solidity
contract Lec5 {
    uint256 public a = 3;
}
```

## private: 오직 private이 정의된 스마트 컨트랙에서만 접근가능 

## external : 오직 밖에서만 접근 가능. 
- external이기에, external이 정의된 스마트 컨트랙 내에서는 사용이 불가능 

## internal : 오직 internal이 정의된 스마트 컨트랙 내에서, 상속받은 자식 스마트 컨트랙에서 접근 가능.
- internal 은 private 과 비슷해요, private에서 한가지 기능(상속받은 자식 접근 가능)이 더 추가 되었다고 생각하시면 됩니다.

## 정리
- public: 모든곳에서 접근 가능
- external: public 처럼 모든곳에서 접근 가능하나, external이 정의된 자기자신 컨트랙 내에서 접근 불가
 
- private: 오직 private이 정의된 자기 컨트랙에서만 가능( private이 정의된 컨트랙을 상속 받은 자식도 불가능)
- internal: private 처럼 오직 internal 이 정의된 자기 컨트랙에서만 가능하고, internal이 정의된 컨트랙을 상속받은 자식들도 접근이 가능

## view
- storage state 를 읽을 수 있지만, 그 state 값을 변경할 수 없다.

## pure 
- storage state 를 읽으면 안되고, 그 state값을 변경할 수 도 없다.