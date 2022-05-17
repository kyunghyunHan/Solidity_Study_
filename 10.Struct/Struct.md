# 구조체
- 복잡한 자료형 
```solidity
struct Person {
  uint age;
  string name;
}
```
## 구조체와 배열 활용
```solidity
struct Person {
  uint age;
  string name;
}

Person[] public people;
// 새로운 사람을 생성한다:
Person satoshi = Person(172, "Satoshi");

// 이 사람을 배열에 추가한다:
people.push(satoshi);
//이 두 코드를 조합하여 깔끔하게 한 줄로 표현할 수 있네:
people.push(Person(16, "Vitalik"));
```