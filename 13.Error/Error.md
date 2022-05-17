# 에러 핸들러1 assert, revert, require 
- assert : gas를 다 소비한후, 특정한 조건에 부합하지 않으면 에러를 발생시킨다.
- revert: 조건없이 에러를 발생시키고, gas를 환불 시켜준다. 
- require: 특정한 조건에 부합하지 않으면 에러를 발생시키고, gas를 환불 시켜준다.

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// require, revert,assert 

contract lec25{
    
    //Gas is not spent
    function revertNow() public pure{
        revert("revert");
    }

    
  }
```

## require
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract lec25{
    function requireNow()public pure{
        require(false,"occurred");
    }
 
}
```

## if+ revert
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract lec25{
    function onlyAdults(uint256 _age) public pure returns(string memory){
        if( _age < 19){
            revert("You are not allowed to pay for the cigarette");
        }
        return "Your payment is scceeded";
        
    }
   
}
```

## 0.8이후
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lec26{

    function assertNow() public pure{
        assert(false);
    }
 }
 ```

 ## try/catch
- try/catch문 안에서, assert/revert/require을 통해 에러가 난다면 catch는 에러를 잡지를 못하고, 개발자가 의도한지 알고 정상적으로 try/catch만 끝낸다
- try/catch문 밖에서 assert/revert/require을 통해 에러가 난다면 catch는 에러를 잡고, 에러를 핸들할수 있다
```
외부 스마트 컨트랙을 함수를 부를때 : 다른 스마트 컨트랙을 인스턴스화 하여서, try/catch문이 있는 스마트 컨트랙의 함수를 불러와서 사용.
외부 스마트 컨트랙을 생성 할 때 : 다른 스마트컨트랙을 인스턴스화 생성 할 때 씀
이 경우들로 도입되었다고 합니다.

```
## catch

- catch Error(string memory reason) { ... } : revert 나 require을 통해 생성된 에러는 이 catch 에 잡힌답니다.
- catch Panic(uint errorCode) { ... } : 26강에서 봤던 Paninc이네여, assert 를 통해 생선된 에러가 날 때 이 catch에 잡혀요. 에러들은, division zero(나누기 0 ), 오버플로우, 배열에 없는 인덱스 접근시 등등이 있답니다.
- catch(bytesmemorylowLevelData){...} : 이 catch는 로우 레벨에러를 잡습니다. 

## 1. 외부 스마트 컨트랙을 함수를 부를때 try/catch
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract math{
    
    function division(uint256 _num1,uint256 _num2) public pure returns (uint256){
        require(_num1<10,"num1 shoud not be more than 10");
        return _num1/_num2;
    }
}

contract runner{
    event catchErr(string _name,string _err);
    event catchPanic(string _name,uint256 _err);
    event catchLowLevelErr(string _name,bytes _err);
 
    math public mathInstance = new math() ;
    
    function playTryCatch(uint256 _num1, uint256 _num2) public returns(uint256,bool){
        
        try mathInstance.division(_num1, _num2) returns(uint256 value){
            return(value,true);
        } catch Error(string memory _err) {
            emit catchErr("revert/require",_err);
            return(0,false);
        } catch Panic(uint256 _errorCode) {
            emit catchPanic("assertError/Panic",_errorCode);
            return(0,false);
        } catch (bytes memory _errorCode) {
            emit catchLowLevelErr("LowlevelError",_errorCode);
            return(0,false);
        }
        
    } 
}
```

## 2. 외부 스마트 컨트랙을 생성 할 때 try/catch
```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract character{
    string private name;
    uint256 private power;
    constructor(string memory _name, uint256 _power){
        name = _name;
        power = _power;
    }

}

contract runner{
    event catchOnly(string _name,string _err);
    function playTryCatch(string memory _name, uint256 _power) public returns(bool successOrFail){
        
        try new character(_name,_power) {
            return(true);
        }
        catch{
            emit catchOnly("catch","ErrorS!!");
            return(false);
        }
        
        
    } 
}



}
```
## 3. 내부 스마트 컨트랙에서 함수를 부를때 try/catch
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract runner2{
    function simple() public returns(uint256){
        return 4;
    }
    event catchOnly(string _name,string _err);
    function playTryCatch() public returns(uint256,bool){
        
        try this.simple() returns(uint256 _value){
            return(_value,true);
        }
        catch{
            emit catchOnly("catch","ErrorS!!");
            return(0,false);
        }
        
        
    } 
}
```
