# Stackup Contract Explanation

## Features
- Create Campaign - allow the admin to create a campaign
- Edit and delete quests - add functions to allow the admin to edit and delete quests

## Explanation
 Here's a description and usage of each function:

1. `createQuest`:
   - Description: This function allows the admin to create a new quest within a campaign.
   - Parameters:
     - `campaignId`: The ID of the campaign in which the quest will be created.
     - `title_`: The title of the quest.
     - `reward_`: The reward associated with completing the quest.
     - `numberOfRewards_`: The number of available rewards for the quest.
   - Usage: The admin calls this function to create a new quest within a campaign, specifying the necessary details.

2. `createCampaign`:
   - Description: This function allows the admin to create a new campaign.
   - Parameters:
     - `title_`: The title of the campaign.
     - `startTime_`: The start time of the campaign (in UNIX timestamp format).
     - `endTime_`: The end time of the campaign (in UNIX timestamp format).
   - Usage: The admin calls this function to create a new campaign, providing the campaign's title and duration.

3. `joinQuest`:
   - Description: This function allows a player to join a quest within a campaign.
   - Parameters:
     - `campaignId`: The ID of the campaign containing the quest.
     - `questId`: The ID of the quest to join.
   - Usage: A player calls this function to join a specific quest within a campaign.

4. `submitQuest`:
   - Description: This function allows a player to submit their completed quest.
   - Parameters:
     - `campaignId`: The ID of the campaign containing the quest.
     - `questId`: The ID of the quest to submit.
   - Usage: A player calls this function to submit their completed quest for review.

5. `deleteQuest`:
   - Description: This function allows the admin to delete a quest within a campaign.
   - Parameters:
     - `campaignId`: The ID of the campaign containing the quest.
     - `questId`: The ID of the quest to delete.
   - Usage: The admin calls this function to delete a specific quest within a campaign.

6. `editQuest`:
   - Description: This function allows the admin to edit the details of a quest within a campaign.
   - Parameters:
     - `campaignId`: The ID of the campaign containing the quest.
     - `questId`: The ID of the quest to edit.
     - `newTitle`: The new title for the quest.
     - `newReward`: The new reward for completing the quest.
     - `newNumberOfRewards`: The new number of available rewards for the quest.
   - Usage: The admin calls this function to update the details of a quest within a campaign.

7. Modifiers:
   - `onlyAdmin`: This modifier restricts access to functions only to the admin address specified in the contract's constructor.
   - `campaignExists`: This modifier verifies that the campaign with the given ID exists before executing the function.

