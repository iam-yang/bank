pragma solidity ^0.8;

contract Bank {
    mapping(address => uint) userDic;
    address owner;

    constructor() payable {
        owner = msg.sender;
    }

    event rec();
    event fall();

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    // 没有任何值的交易会触发receive
    receive() external payable {
        userDic[msg.sender] = msg.value;

        emit rec();
    }

    // 有值但匹配不上的会触发fallback
    fallback() external payable {
        emit fall();
    }

    function myFund() public view returns (uint) {
        return userDic[msg.sender];
    }

    function withdraw() public {
        require(userDic[msg.sender] > 0, "balance insuficent");
        payable(msg.sender).transfer(userDic[msg.sender]);
    }

    function rugPull() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
