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
- index0수정
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
 
contract lec18{
    
    uint256[] public ageArray;

    function Agepush(uint256 _age)public{
        ageArray.push(_age);
    }
    function AgeChange(uint256 _index, uint256 _age)public{
        ageArray[_index] = _age;
    }

}
```
## 배열의 값 지우기
- Pop :가장 최신의 값을 지운다/ length 도 줄어든다 
- delete: 원하는 인덱스의 값을 지운다, 그러나 length 는 줄어들지 않는다
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
 
contract lec18{
    
    
    uint256[] public ageArray;

    function AgePop()public {
        ageArray.pop();
    }
    
    function AgePop(uint256 _index)public {
        delete ageArray[_index];
    }

    
    
}
```
- 참고 
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
 
contract lec18{
    
    
    uint256[] public ageArray;
    uint256[10] public ageFixedSizeArray;
    string[] public nameArray= ["Kal","Jhon","Kerri"];
  
    function AgeLength()public view returns(uint256) {
        return ageArray.length;
    }
    
    function AgePush(uint256 _age)public{
        ageArray.push(_age);
    }
    function AgeChange(uint256 _index, uint256 _age)public{
        ageArray[_index] = _age;
    }
    function AgeGet(uint256 _index)public view returns(uint256){
        return ageArray[_index];
    }
    function AgePop()public {
        ageArray.pop();
    }
    
    function AgePop(uint256 _index)public {
        delete ageArray[_index];
    }


}
```