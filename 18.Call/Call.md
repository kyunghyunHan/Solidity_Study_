# Call
- abi를 통해서 함수를 접근합니다. 
- abi 안에는 컴파일된 스마트컨트랙의 정보가 담겨 있습니다, 이것을 통하여, 스마트 컨트랙을 접근을 합니다.

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract add{
    event JustFallback(string _str);
    function addNumber(uint256 _num1, uint256 _num2) public pure returns(uint256){
        return _num1 + _num2;
    }
    fallback() external {
     emit JustFallback("JustFallback is called");
    }
}

contract caller{
    event calledFunction(bool _success, bytes _output);
   
    //1. 송금하기 
    function transferEther(address payable _to) public payable{
        (bool success,) = _to.call{value:msg.value}("");
        require(success,"failed to transfer ether");
    }
    
    //2. 외부 스마트 컨트랙 함수 부르기 
    function callMethod(address _contractAddr,uint256 _num1, uint256 _num2) public{
        (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call(
              abi.encodeWithSignature("addNumber2(uint256,uint256)",_num1,_num2)
              );
        require(success,"failed to transfer ether");
        emit calledFunction(success,outputFromCalledFunction);
    }
}
```

## delegate call 

```
alice ->callb -> 스마트컨트렉a ->changeb ->스마트컨트렉b
```
- 스마트컨트렉a와 스마트컨트렉b의 msg.sender은 다르다
- alice라는 주체가 스마트 a를 불럿기 떄문에 스마트커트렉a 의 msgsender은 alice의 주소
- 스마트컨트렉 b의 msgsender은 alice의 주소가 아니라 스마크컨트렉a의 주소
- 스마트 컨트렉a 의call이 실질적으로 스마트컨트렉 b의 함수를 부른거기 떄문에
- 알수있는 3가지
```
1. 스마트 컨트랙 A의 msg.sender 는 Alice 의 주소
2. 스마트 컨트랙 B의 msg.sender 는 스마트 컨트랙 A의 주소
3. 스마트 컨트랙 B의 num은 5로 변경되고, num=5라는 것은 스마트 컨트랙B 에 저장이된다. 
```

- delegate call이 call과 크게 다른 점
```
1. 스마트컨트랙 B의 msg.sender는 스마트 컨트랙 A 주소가 아니라, Alice의 주소 이다. 
2. 스마트 컨트랙 B의 함수가 불려서, num의 값은 5가 됬지만, 정작 num=5라는 것은 스마트컨트랙 A에 저장이되어있고, 스마트 컨트랙B의 num의 값은 그대로 3이다. 

```
- 즉 delegate call은 스마트컨트랙 b의 함수를 스마트컨트렉a에 옮겨놓은 것처럼 행동
- 스마트컨트렉 a는 껍데기, 스마트컨트렉b는 주요 함수를 갖고 있는 핵심

## delegate call이 필요한 이유
- 재배포 하면 기존의 사용하던 고객들의 정보가 초기화
- 스마트컨트랙a와 b의 주소가 재배포하게되면 변경
- 즉 스마트컨트렉트a는 껍데기 이니까 스마트컨트렉 b의 주요로직을 변경해서 새로운 스마트컨트랙b를 배포하고 기존의 delegatecall의 주소를 스마트컨트랙 b ->스마트컨트렉b`으로 변경해주면 코드를 변경할수 있다
- 이렇게하면 스마트컨트렉a에 데이터가 저장되고 스마트 컨트렉a를 새로 배포한게 아니니 데이터 보존가능 
- 그리고 유저는 스마트컨트렉 a를 통해 상호작용 하니 스마트컨트렉a의 주소가 변경되지 않으니 유저가 신경 x



##  이거를 upgradeble smart contract framework이라 부른다