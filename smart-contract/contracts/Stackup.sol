// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StackUp {
    enum PlayerQuestStatus {
        NOT_JOINED,
        JOINED,
        SUBMITTED
    }

    enum SubmissionStatus {
        PENDING,
        APPROVED,
        REJECTED
    }

    struct Quest {
        uint256 questId;
        uint256 numberOfPlayers;
        string title;
        uint8 reward;
        uint256 numberOfRewards;
        mapping(address => SubmissionStatus) submissions;
    }

    struct Campaign {
        uint256 campaignId;
        string title;
        uint256 startTime;
        uint256 endTime;
        mapping(uint256 => Quest) quests;
        uint256 nextQuestId;
    }

    address public admin;
    uint256 public nextCampaignId;
    mapping(uint256 => Campaign) public campaigns;
    mapping(address => mapping(uint256 => PlayerQuestStatus))
        public playerQuestStatuses;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function createQuest(
        uint256 campaignId,
        string calldata title_,
        uint8 reward_,
        uint256 numberOfRewards_
    ) external onlyAdmin campaignExists(campaignId) {
        Campaign storage campaign = campaigns[campaignId];
        uint256 questId = campaign.nextQuestId;
        campaign.nextQuestId++;

        campaign.quests[questId].questId = questId;
        campaign.quests[questId].numberOfPlayers = 0;
        campaign.quests[questId].title = title_;
        campaign.quests[questId].reward = reward_;
        campaign.quests[questId].numberOfRewards = numberOfRewards_;
    }

    function createCampaign(
        string calldata title_,
        uint256 startTime_,
        uint256 endTime_
    ) external onlyAdmin {
        Campaign storage campaign = campaigns[nextCampaignId];
        campaign.campaignId = nextCampaignId;
        campaign.title = title_;
        campaign.startTime = startTime_;
        campaign.endTime = endTime_;
        nextCampaignId++;
    }

    function joinQuest(uint256 campaignId, uint256 questId) external {
        Campaign storage campaign = campaigns[campaignId];
        Quest storage quest = campaign.quests[questId];

        require(quest.questId != 0, "Quest does not exist");
        require(
            playerQuestStatuses[msg.sender][quest.questId] ==
                PlayerQuestStatus.NOT_JOINED,
            "Player has already joined/submitted this quest"
        );
        require(
            block.timestamp >= campaign.startTime &&
                block.timestamp <= campaign.endTime,
            "Campaign is not active"
        );

        playerQuestStatuses[msg.sender][quest.questId] = PlayerQuestStatus
            .JOINED;
        quest.numberOfPlayers++;
    }

    function submitQuest(uint256 campaignId, uint256 questId) external {
        Campaign storage campaign = campaigns[campaignId];
        Quest storage quest = campaign.quests[questId];

        require(quest.questId != 0, "Quest does not exist");
        require(
            playerQuestStatuses[msg.sender][quest.questId] ==
                PlayerQuestStatus.JOINED,
            "Player must first join the quest"
        );

        playerQuestStatuses[msg.sender][quest.questId] = PlayerQuestStatus
            .SUBMITTED;
        quest.submissions[msg.sender] = SubmissionStatus.PENDING;
    }

    function deleteQuest(
        uint256 campaignId,
        uint256 questId
    ) external onlyAdmin {
        Campaign storage campaign = campaigns[campaignId];
        Quest storage quest = campaign.quests[questId];

        require(quest.questId != 0, "Quest does not exist");

        delete quest.submissions[msg.sender];
        delete campaign.quests[questId];
    }

    function editQuest(
        uint256 campaignId,
        uint256 questId,
        string calldata newTitle,
        uint8 newReward,
        uint256 newNumberOfRewards
    ) external onlyAdmin {
        Campaign storage campaign = campaigns[campaignId];
        Quest storage quest = campaign.quests[questId];

        require(quest.questId != 0, "Quest does not exist");

        quest.title = newTitle;
        quest.reward = newReward;
        quest.numberOfRewards = newNumberOfRewards;
    }

    modifier campaignExists(uint256 campaignId) {
        require(
            campaigns[campaignId].campaignId != 0,
            "Campaign does not exist"
        );
        _;
    }
}
