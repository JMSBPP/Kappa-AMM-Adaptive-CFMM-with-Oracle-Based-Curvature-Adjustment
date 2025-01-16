// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract subscriptionManagementState {
    enum SubscriptionState {
        SUBSCRIBING,
        SUBSCRIBED
    }
    //security:
    // How an attacker can modify a private mapping?
    //  What incentives would he has to do so?
    SubscriptionState internal subscriptionState;
    mapping(address => mapping(address => bool)) internal subscribers;
    // protocol:
    //  UP TO HOW MANY SUBSCRIBERS DETERMINES uint(?) ?
    //security:
    //   How an attacker can modify a private mapping?
    //   What incentives would he has to do so?
    mapping(address => uint112) internal subscribersCount;
    //ENTRY EVENTS FOR SUBSCRIPTION

    //RECEIVE INPUT EVENT

    //EXIT EVENTS FOR SUBSCRIPTION
}
