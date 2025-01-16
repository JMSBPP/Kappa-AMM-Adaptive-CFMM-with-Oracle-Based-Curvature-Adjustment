// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract subscriptionManagementState {
    //security:
    // How an attacker can modify a private mapping?
    //  What incentives would he has to do so?

    mapping(address => mapping(address => bool)) internal subscribers;
    // protocol:
    //  UP TO HOW MANY SUBSCRIBERS DETERMINES uint(?) ?
    //security:
    //   How an attacker can modify a private mapping?
    //   What incentives would he has to do so?
    mapping(address => uint112) internal subscribersCount;
    //ENTRY EVENTS FOR SUBSCRIPTION
    function checkSubscribePreConditions() external returns (bool) {
        return true;
    }

    //RECEIVE INPUT EVENT
    function inputSubscribeEvent() external returns (bool) {
        return true;
    }

    //EXIT EVENTS FOR SUBSCRIPTION

    function checkSubscribePostConditions() external returns (bool) {
        return true;
    }
}
