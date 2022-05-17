# Array
- 솔리디티에는 정적배열과 동적배열
```solidity
// 2개의 원소를 담을 수 있는 고정 길이의 배열:
uint[2] fixedArray;
// 또다른 고정 배열으로 5개의 스트링을 담을 수 있다:
string[5] stringArray;
// 동적 배열은 고정된 크기가 없으며 계속 크기가 커질 수 있다: 
//golang 의 슬라이스같은
uint[] dynamicArray;
```