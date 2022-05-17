# 반복문
## for문
```solidity
function getEvens() pure external returns(uint[]) {
  uint[] memory evens = new uint[](5);
  // 새로운 배열의 인덱스를 추적하는 변수
  uint counter = 0;
  // for 반복문에서 1부터 10까지 반복함
  for (uint i = 1; i <= 10; i++) {
    // `i`가 짝수라면...
    if (i % 2 == 0) {
      // 배열에 i를 추가함
      evens[counter] = i;
      // `evens`의 다음 빈 인덱스 값으로 counter를 증가시킴
      counter++;
    }
  }
  return evens;
}
```
## while문
```
  초기값

    while (값이 얼마나 forloop을 돌아야하는지) {
    whileloop 내용
    whileloop 한번 돌때마다 값의 변화;

    }
```
```solidity
 function whileLoopEvents() public {
        uint256 i = 0;
        while(i<countryList.length){
             emit CountryIndexName(i,countryList[i]);
             i++;
        }
    }
```
## Do-while 
```
  초기값
    do{
          dowhileloop 내용
    }
    while (값이 얼마나 forloop을 돌아야하는지)
```
```solidity
  function doWhileLoopEvents() public {
        uint256 i = 0;
        do{
            emit CountryIndexName(i,countryList[i]);
            i++;
        }
        while(i<countryList.length);
    }

```
## linear search
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract lec24{
    string[] private countryList = ["South Korea","North Korea","USA","China","Japan"];
    
    function linearSearch(string memory _search) public view returns(int256,string memory){
        
        for(uint256 i=0; i<countryList.length; i++){
            if(keccak256(bytes(countryList[i])) == keccak256(bytes(_search))){
                return (i,countryList[i]);
            }
        }
        
        return(99,"Nothing");
        
    }

}
```
