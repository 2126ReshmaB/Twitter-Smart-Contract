// SPDX-License-Identifier: MIT (open source)

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.26;

// 1. Create a Twitter Contract
// 2. Create a mapping between user and tweet
// 3. Add a function to create a tweet and save it in mapping
// 4. Create a function to get Tweet
// 5. Add array of Tweets
// 6. Structs for multiple data types
// 7. require (conditional)
// 8. add likes
// 9. Events 
//     - create Event for creating the tweet, called TweetCreated
//     - Emit the Event in the createTweet() function below
//     - Create Event for liking the tweet, called TweetLiked
//     - Emit the event in the likeTweet() function below
// 10. Inheritance
// 11. Communicating with contracts (using interfaces)

interface IProfile {
      struct UserProfile {
        string displayName;
        string bio;
      }
      function getProfiel(address _user) external view returns (UserProfile memory);
}

contract Twitter is Ownable{
      uint16 public MAX_TWEET_LENGTH = 280;
      struct Tweet{
            uint256 id;
            address author;
            string content;
            uint timestamp;
            uint likes;
      }
      mapping(address => Tweet[]) public tweets;

      // address public owner;

      IProfile profileContract;

      // create Event
      event TweetCreated(uint256 id,address author,string content, uint256 timestamp);
      event TweetLiked(address liker,address tweetAuthor,uint256 tweetId,uint256 newLikedCount);
      event TweetUnliked(address unliker,address tweetAuthor,uint256 tweetId,uint256 newUnlikedCount);

      constructor(address _contractAddress) Ownable(msg.sender){
            // owner = msg.sender;
            profileContract = IProfile(_contractAddress);
      }
      // modifier onlyOwner {
      //       require(msg.sender == owner,"You'r not an Owner!");
      //       _;
      // }

      modifier onlyRegistered {
            IProfile.UserProfile memory userProfileTemp = profileContract.getProfiel(msg.sender);
            require(bytes(userProfileTemp.displayName).length > 0, "User not Registered");
            _;
      }
      function changeTweetLength(uint16 newLength) public onlyOwner{
            MAX_TWEET_LENGTH = newLength;
      }

      function getTotalLikes(address _author) external view returns (uint){
            uint totalLikes = 0;
            for(uint i=0;i<tweets[_author].length;i++){
                  totalLikes += tweets[_author][i].likes;
            }
            return totalLikes;
      }

      function createTweets(string memory _tweet) public onlyRegistered{

         require(bytes(_tweet).length <= MAX_TWEET_LENGTH,"Tweet is too long!");

         Tweet memory newTweet = Tweet(
                  {
                        id: tweets[msg.sender].length,
                        author: msg.sender,
                        content: _tweet,
                        timestamp: block.timestamp,
                        likes: 0
                  }
            );
            tweets[msg.sender].push(newTweet);

            emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
      } 
      function likeTweet(address author,uint256 id) external onlyRegistered{
            require(tweets[author][id].id == id,"TWEET DOES NOT EXIST");
            tweets[author][id].likes++;

            emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
      }
      function unlikeTweet(address author,uint256 id) external {
            require(tweets[author][id].id == id,"TWEET DOES NOT EXIST");
            require(tweets[author][id].likes > 0,"LIKE IS NOT POSSIBLE");

            tweets[author][id].likes--;

            emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
      }
      function getTweet(uint _i) public view returns (Tweet memory) {
            return tweets[msg.sender][_i];
      }
      function getAllTweets(address _owner) public view returns (Tweet[] memory){
            return tweets[_owner];
      }
}
