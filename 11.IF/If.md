# 조건문
```solidity
    string private result = "";

    function isIt5(uint256 _number) public returns(string memory){
        if(_number == 5){
            result = "Yes, it is 5";
            return result;
        }
        result = "No, it is not 5";
        return result;
    }
 ```
## else if
 ```
        if(if가 발동 되는 조건){
        if 내용 
    }
    else if(else if가 발동 되는 조건){
        else if 내용 
    }
    ...
    else{ if, else if 가 발동이 안되면
        else 내용 
    }
  ```
  