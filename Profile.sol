// SPDX-License-Identifier: MIT (open source)

pragma solidity ^0.8.26;

contract Profile {
    struct UserProfile {
        string displayName;
        string bio;
    }

    mapping(address => UserProfile) public profiles;

    function setProfile(string memory _displayName,string memory _bio) public {
        profiles[msg.sender] = UserProfile(_displayName,_bio);
    }
    function getProfiel(address _user) public view returns (UserProfile memory) {
        return profiles[_user];
    }
}
