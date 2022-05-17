

    // SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Loop{
     event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea","North Korea","USA","China","Japan"];

    function forLoopEvents() public {
        for(uint256 i =0; i<countryList.length; i++){
        emit CountryIndexName(i,countryList[i]);
        }
    }
 
}