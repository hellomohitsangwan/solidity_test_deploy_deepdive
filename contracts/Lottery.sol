// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Lottery {

    address public manager;
    address[] public people;

    constructor() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);
        
        people.push(msg.sender  );
    }
    function pickWinner() public restricted payable {
       payable(people[generateRandom() % people.length]).transfer(address(this).balance);  // this.balance = return the balance of the contract

        people = new address[](0);  //resetting the people array to 0 so that new people can participate
    }
    function generateRandom() public view returns(uint) {
        return uint(keccak256("hustle"));    
    }
    function showParticipants() public view restricted returns(address[] memory) {
        return people;
    }
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}
