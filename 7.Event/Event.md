# Event
- 이벤트는 컨트렉트가 블록체인 상에서 앱의 사용자 단에서 무언가 액션이 발생했을떄 의사소통하는 방법
```solidity
// 이벤트를 선언한다
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public {
  uint result = _x + _y;
  // 이벤트를 실행하여 앱에게 add 함수가 실행되었음을 알린다:
  IntegersAdded(_x, _y, result);
  return result;
}
```