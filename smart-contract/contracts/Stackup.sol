// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StackUp {
    enum playerQuestStatus {
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
        uint256 campaignId;
    }

    struct Campaign {
        uint256 campaignId;
        string title;
        uint256 startTime;
        uint256 endTime;
    }

    address public admin;
    uint256 public nextQuestId;
    uint256 public nextCampaignId;
    mapping(uint256 => Quest) public quests;
    mapping(uint256 => Campaign) public campaigns;
    mapping(uint256 => mapping(uint256 => uint256)) public questsByCampaign;
    mapping(address => mapping(uint256 => playerQuestStatus))
        public playerQuestStatuses;
    mapping(address => mapping(uint256 => SubmissionStatus))
        public submissionStatuses;
    mapping(uint256 => uint256) public questStartTimes;
    mapping(uint256 => uint256) public questEndTimes;

    constructor() {
        admin = msg.sender;
    }

    modifier questExists(uint256 questId) {
        require(quests[questId].reward != 0, "Quest does not exist");
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    function createQuest(
        uint256 campaignId,
        string calldata title_,
        uint8 reward_,
        uint256 numberOfRewards_
    ) external onlyAdmin {
        require(msg.sender == admin, "Only the admin can create quests");

        uint256 questId = nextQuestId++;
        quests[questId] = Quest(
            questId,
            0,
            title_,
            reward_,
            numberOfRewards_,
            campaignId
        );
        questsByCampaign[campaignId][questId] = questId;
    }

    function editQuest(
        uint256 questId,
        string calldata newTitle,
        uint8 newReward,
        uint256 newNumberOfRewards
    ) external questExists(questId) onlyAdmin {
        Quest storage thisQuest = quests[questId];
        thisQuest.title = newTitle;
        thisQuest.reward = newReward;
        thisQuest.numberOfRewards = newNumberOfRewards;
    }

    function deleteQuest(
        uint256 questId
    ) external questExists(questId) onlyAdmin {
        delete quests[questId];
        // You may also want to delete related data such as playerQuestStatuses and submissionStatuses
    }

    function joinQuest(uint256 questId) external questExists(questId) {
        require(
            playerQuestStatuses[msg.sender][questId] ==
                playerQuestStatus.NOT_JOINED,
            "Player has already joined/submitted this quest"
        );

        playerQuestStatuses[msg.sender][questId] = playerQuestStatus.JOINED;
        quests[questId].numberOfPlayers++;
    }

    function submitQuest(uint256 questId) external questExists(questId) {
        require(
            playerQuestStatuses[msg.sender][questId] ==
                playerQuestStatus.JOINED,
            "Player must first join the quest"
        );

        playerQuestStatuses[msg.sender][questId] = playerQuestStatus.SUBMITTED;
        submissionStatuses[msg.sender][questId] = SubmissionStatus.PENDING;
    }

    // function reviewQuestSubmission(
    //     uint256 questId,
    //     address player,
    //     SubmissionStatus status
    // ) external questExists(questId) onlyAdmin {
}
