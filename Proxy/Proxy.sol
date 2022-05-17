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
