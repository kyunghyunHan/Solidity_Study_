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

## ->분해
1. 먼저 호출 데이터를 메모리에 로드해야 합니다. 처음 두 줄에서 이를 수행합니다.
```solidity
let ptr := mload(0x40)
calldatacopy(ptr, 0, calldatasize())
```
2. 다음으로 호출을 중계합니다.
```solidity
let result := delegatecall(
    gas(),
    sload(implementation.slot),
    ptr,
    calldatasize(),
    0,
    0
)
```
3. 이전에 사용한 두 가지 호출 데이터 함수와 유사한 함수를 사용할 것입니다.
```solidity
let size := returndatasize()
returndatacopy(ptr, 0, size)
```
4. 마지막으로 중계된 호출이 성공하고 돌아오는지 확인합니다. 그렇지 않으면 되돌릴 것입니다. 두 경우 모두 중계된 호출에서 반환된 데이터를 사용하고 있음을 주목하세요. 호출에서 반환된 것을 반환하고 호출이 되돌린 경우 동일한 메시지로 되돌리기를 원합니다.

```solidity
describe("Proxy", async () => {
  let owner;
  let proxy, logic;

  beforeEach(async () => {
    [owner] = await ethers.getSigners();

    const Logic = await ethers.getContractFactory("Logic");
    logic = await Logic.deploy();
    await logic.deployed();

    const Proxy = await ethers.getContractFactory("Proxy");
    proxy = await Proxy.deploy();
    await proxy.deployed();

    await proxy.setImplementation(logic.address);
  });
```
- 그런 다음 구현 계약 주소가 올바르게 설정되었는지 확인합니다.
```solidity
it("points to an implementation contract", async () => {
  expect(await proxy.implementation()).to.eq(logic.address);
});
```
그런 다음 프록시가 작동하는지 확인합니다.
```solidity
it("proxies calls to implementation contract", async () => {
  abi = [
    "function setMagicNumber(uint256 newMagicNumber) public",
    "function getMagicNumber() public view returns (uint256)",
  ];

  const proxied = new ethers.Contract(proxy.address, abi, owner);

  expect(await proxied.getMagicNumber()).to.eq("0x42");
});
```

## Test
```
1) Proxy
proxies calls to implementation contract:
AssertionError: Expected "912823093544680850579175995568783282090442467040" to be equal 0x42

```
##  DELEGATECALL
1. 상태: 메모리 또는 영구 저장소에 저장되고 프로그램에서 사용하는 데이터입니다.
2. 프로그램의 기능인 논리.

1. 를 사용할 때 call호출자와 호출 수신자는 고유한 분리된 상태를 갖습니다. 이것은 의미가 있으며 이것이 기본적으로 우리가 기대하는 것입니다.
2. delegatecall가 사용되면 호출 수신자는 호출자의 상태를 사용합니다 . 그게 다야: 당신이 호출하는 계약 delegatecall은 호출자 계약의 상태를 사용합니다.
