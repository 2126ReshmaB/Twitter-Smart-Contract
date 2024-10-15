# Twitter-Smart-Contract

This project implements a basic Twitter-like functionality using Solidity Smart Contracts. Users can create tweets, like/unlike tweets, and retrieve tweets—all while leveraging core Solidity concepts like structs, mappings, and events.

## Features
- Create Tweets: Users can create tweets (up to a specified character limit).
- Like/Unlike Tweets: Users can like or unlike tweets from other users.
- Event Emission: Events are emitted when tweets are created or liked.
- Admin Controls: Contract owner can modify the maximum tweet length.
- Profile Check: Users must be registered via an external profile contract to interact with tweets.

## Technologies Used
- Solidity: Version ^0.8.26
- OpenZeppelin: For secure contract patterns like Ownable.
- MetaMask: For deploying and interacting with the contract.
- Ethereum (EVM): The blockchain platform.
## Smart Contract Breakdown
- Structs: Defines Tweet structure with properties like id, author, content, timestamp, and likes.
- Mapping: Tweets are stored in a mapping with the user's address as the key.
- Modifiers: onlyOwner for admin functionality and onlyRegistered to ensure user registration via an external contract.
- Events: TweetCreated and TweetLiked are emitted during the respective actions.
- Inheritance: Uses Ownable from OpenZeppelin for ownership control.
## Core Functions
- createTweet(string memory _tweet): Allows registered users to create a tweet.
- likeTweet(address _author, uint256 id): Allows users to like a tweet.
- unlikeTweet(address _author, uint256 id): Allows users to unlike a tweet.
- changeTweetLength(uint16 newLength): Admin-only function to change the tweet length.
- getTweet(uint256 _i): Retrieves a tweet from the caller's tweet list.
- getAllTweets(address _owner): Returns all tweets created by the specified owner.
## Events
TweetCreated: Triggered when a new tweet is created.
TweetLiked: Triggered when a tweet is liked.
TweetUnliked: Triggered when a tweet is unliked.
## Installation and Setup
### Prerequisites
MetaMask browser extension (for deploying and interacting with the contract).
