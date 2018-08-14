pragma solidity 0.4.24;

contract Meet {
    // variable
    bool isLive;
    uint sum = 0;
    uint money;
    uint pay;
    address[] member;
    address[] arrived;
    address[] moneyMember;

    // mapping

    // event
    event AddMember(address member);
    event Meeting(address member);
    event Arrived(address member);
    event Finish(uint sum);

    // modifier
    modifier inMember {
        for (uint i = 0; i < member.length; ++i) {
            if (member[i] == msg.sender) {
                _;
            }
        }
    }

    modifier noMember {
        for (uint i = 0; i < member.length; ++i) {
            if (member[i] == msg.sender) {
                revert();
            }
        }
        _;
    }

    modifier isArrived {
        for (uint i = 0; i < arrived.length; ++i) {
            if (arrived[i] == msg.sender) {
                _;
            }
        }
    }

    modifier noArrived {
        for (uint i = 0; i < arrived.length; ++i) {
            if (arrived[i] == msg.sender) {
                revert();
            }
        }
        _;
    }

    modifier noReceive {
        for (uint i = 0; i < moneyMember.length; ++i) {
            if (moneyMember[i] == msg.sender) {
                revert();
            }
        }
        _;
    }


    // constructor
    constructor(uint _pay) public {
        isLive = true;
        pay = _pay;
        addMember();
        emit Meeting(msg.sender);
    }

    // function
    function addMember() public noMember {
        require(isLive);
        // require(msg.value >= pay);

        // msg.sender.call.value(msg.value).gas(pay)();
        sum += pay;
        member.push(msg.sender);
        emit AddMember(msg.sender);
    }

    function arrive() public inMember noArrived {
        require(isLive);
        arrived.push(msg.sender);

        emit Arrived(msg.sender);
    }

    function finish() public inMember isArrived noReceive {
        // 시간은 어떻게 처리하지..
        if (isLive) {
            money = sum/arrived.length;
        }
        isLive = false;
        moneyMember.push(msg.sender);
        // msg.sender.transfer(money);

        emit Finish(sum);
    }

}
