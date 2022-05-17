# 상속
- 컨트렉트 상속
- 변수와 함수들을 상속
```solidity
contract Doge {
  function catchphrase() public returns (string) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string) {
    return "Such Moon BabyDoge";
  }
}
```
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father{
    string public familyName = "Kim";
    string public givenName = "Jung";
    uint256 public money = 100; 
    
    constructor(string memory _givenName) public {
        givenName = _givenName;
    }
    
    
    function getFamilyName() view public  returns(string memory){
        return familyName;
    } 
    
    function getGivenName() view public  returns(string memory){
        return givenName;
    } 
    
    function getMoney() view public returns(uint256){
        return money;
    }
    

}

contract Son is Father("James"){
    
  

}
```

## 오버라이딩
- 상속받은 함수를 덮어쓰기
- 오버라이딩 하기위해서는 함수 앞에 virtual을 명시
```solidity
   function getMoney() view  public virtual returns(uint256){
        return money;
    }
```
```solidity
contract Son is Father("James"){
    
    uint256 public earning = 0;
    function work() public {
        earning += 100;
    }
    
     function getMoney() view  public override returns(uint256){
        return money+earning;
    }

}
```
- getMoney의 내용들을 맘대로 바꿀수 있다.

## 두개 이상 상속
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;


contract Father{
}

contract Mother{
}


contract Son is Father,Mother{
}
```
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;


contract Father{
    uint256 public fatherMoney = 100;
    function getFatherName() public pure returns(string memory){
        return "KimJung";
    }
    
    function getMoney() public view virtual returns(uint256){
        return fatherMoney;
    }
    
}

contract Mother{
    uint256 public motherMoney = 500;
    function getMotherName() public  pure returns(string memory){
        return "Leesol";
    }
    function getMoney() public view virtual returns(uint256){
        return motherMoney;
    }
}


contract Son is Father, Mother {

    function getMoney() public view override(Father,Mother) returns(uint256){
        return fatherMoney+motherMoney;
    }
}
```
## Super
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father {
    event FatherName(string name);
    function who() public virtual{
        emit FatherName("KimDaeho");
    }
}

contract Mother {
    event MotherName(string name);
    function who() public virtual{
        emit MotherName("leeSol");
    }
}

contract Son is Father{
    event sonName(string name);
    function who() public override{
        super.who();
        emit sonName("KimJin");
    }
}
```
## 상속의 순서
- who라는 똑같은 함수가 있고
- Son 이라는 스마트컨트랙트는 Father와 Mother를 상속
- who함수에 오바라이딩을 하여서 super.who()
```solidity
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father {
    event FatherName(string name);
    function who() public virtual{
        emit FatherName("KimDaeho");
    }
}

contract Mother {
    event MotherName(string name);
    function who() public virtual{
        emit MotherName("leeSol");
    }
}

contract Son is Father, Mother{
    
    function who() public override(Father,Mother){
        super.who();
    }
}
```
- 그러면 여기서 Father 와 Mother 누구의 것이 상속이 될까요? 
- 정답은 Mother의 것이 상속되어서 leeSol 이 반환됩니다.
- 정답은 Son is Father , Mother 이기 때문입니다. 즉 Mother 두번째 (최신) 으로 상속 받았기에 그렇습니다.