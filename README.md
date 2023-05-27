# Stackup Contract Explanation

## Features
- Quest review functionality - allow the admin to reject, approve or reward submissions
- Edit and delete quests - add functions to allow the admin to edit and delete quests
- Quest start and end time - add the quest start and end times for each quest struct as well as its corresponding effects e.g. users cannot join a quest that has ended

## Explanation
- Quest Review
> This feature adds new status for the quest. REJECTED, APPROVED, and REWARDED status was added for the admin to decide how the quest status should be. This function needs to be called only when the quest is SUMBITTED, hence the require SUBMITTED status. All three status get their own function to call by onlyAdmin(new modifier); rejectQuest, approveQuest, and rewardQuests needs campaignId, questId, and user address as the parameters. Only the reward function needs to be payable since the rewards needs to be transfered by the admin.
    
- Edit and Delete Quests
> This feature is a simple update to edit and delete the quests. Accessing from the campaign new data structure
    
- Quest Start and End Time
> This feature is a simple update to restrict the user when entering and submitting a quest
    
