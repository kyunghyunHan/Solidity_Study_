# Upgradeable proxy contract from scratch
- 구현 계약을 다른 것으로 바꾸는 것이 가능

## Proxy smart contracts
- 구현 계약을 다른 것으로 바꾸는 것이 가능
```solidity
pragma solidity ^0.8.4;

contract Logic {
  uint256 magicNumber;

  constructor() {
    magicNumber = 0x42;
  }

  function setMagicNumber(uint256 newMagicNumber) public {
    magicNumber = newMagicNumber;
  }

  function getMagicNumber() public view returns (uint256) {
    return magicNumber;
  }
}
```
- 이제 프록시 계약을 단계별로 작성
```solidity
pragma solidity ^0.8.4;

contract Proxy {
     address public implementation;

  function setImplementation(address implementation_) public {
    implementation = implementation_;
  }

  function getImplementation() public view returns (address) {
    return implementation;
  }
}
```

- Solidity에는 계약에서 지원하지 않는 함수가 호출될 때마다 호출되는 특별한 fallback 함수가 있습니다
- 이 함수는... fallback! 불행히도 Solidity가 더 높은 수준의 추상화이기 때문에 이것이 Solidity가 여기에서 우리에게 줄 수 있는 전부입니다. 목표를 달성하려면 더 깊이 들어가야 합니다!

## 계약 함수가 호출되는 방법
- 특정 계약 기능을 호출하는 데 필요한 정보인 호출 데이터 를 포함 합니다. 이 정보에는 다음이 포함됩니다.
```
1.해시된 함수 서명의 처음 4바이트로 정의되는 함수 식별자, 예:
keccak256("transfer(address,uint256)")
2.함수 식별자 다음에 오는 함수 인수 는 ABI 사양 에 따라 인코딩됩니다 .

```
```solidity
fallback() external {
  assembly {
    let ptr := mload(0x40)
    calldatacopy(ptr, 0, calldatasize())

    let result := delegatecall(
      gas(),
      sload(implementation.slot),
      ptr,
      calldatasize(),
      0,
      0
    )

    let size := returndatasize()
    returndatacopy(ptr, 0, size)

    switch result
    case 0 {
      revert(ptr, size)
    }
    default {
      return(ptr, size)
    }
  }
}
```