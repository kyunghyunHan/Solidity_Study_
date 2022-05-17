# instance 
- 인스턴스는 주로 하나의 컨트랙에서 다른 컨트랙을 접근할 때 쓰인답니다.
- 컨트랙이름  인스터스의 이름 = new  컨트랙이름();
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract A{
    
    uint256 public a = 5;
    
    function change(uint256 _value) public {
        a = _value;
    } 

}

contract B{
    
    A instance = new A();
    
    function get_A() public view returns(uint256) {
        return instance.a();
    }
    function change_A(uint256 _value) public  {
        instance.change(_value);
    }    

}
```
- change_A에서는 instance.change(_value) 로 해줌으로써, 컨트랙 A의 함수 change를 접근할걸 알 수가 있습니다.
- 그리고 한가지더, 변수를 접근할때는 () 를 붙여 줘야 리턴 가능

## 생성자 Constrictor
- 생성자는 스마트컨트렉이 생성 또는 배포 그리고 인스턴스화 뙬떄 초기값을 설정하는 용도
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract A{
    
    string public name;
    uint256 public age;
    
    constructor(string memory _name, uint256 _age){
        name = _name;
        age = _age;
    }
        
}

contract B{
    
  A instance = new A("Alice", 52);

}
```
- A컨트랙트에 constructior이 있음(A를 인스턴스 화 하기위한 초기값)