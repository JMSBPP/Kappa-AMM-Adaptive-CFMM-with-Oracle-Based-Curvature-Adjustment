// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract subscriptionManagementState {
    enum SubscriptionState {
        IDLE,
        SUBSCRIBING,
        SUBSCRIBED,
        FAILED
    }

    enum deploymentState {
        INITIALIZING,
        NOT_INITIALIZING
    }

    //security:
    // How an attacker can modify a private mapping?
    //  What incentives would he has to do so?

    mapping(address => SubscriptionState) internal subscriptionState;
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

    address private volumeRouter;

    //this function requires permission
    function setVolumeRouter(address _volumeRouter) internal {
        volumeRouter = _volumeRouter;
    }

    function getVolumeRouter() internal view returns (address) {
        return volumeRouter;
    }
}
