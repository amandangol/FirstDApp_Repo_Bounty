const hre = require("hardhat");

async function main() {
  const StackUp = await hre.ethers.getContractFactory("StackUp");
  const stackUp = await StackUp.deploy();

  await stackUp.deployed();

  console.log("stackUp deployed to:", stackUp.address);

  let adminAddr = await stackUp.admin();
  console.log("admin address:", adminAddr);

  // Create quests with four arguments: title, numberOfPlayers, reward, duration
  await stackUp.createQuest("Introduction to Hardhat", 2, 600, 3600); // 1 hour duration
  await stackUp.createQuest("Unit Testing with Hardhat", 4, 500, 7200); // 2 hours duration
  await stackUp.createQuest("Debugging and Deploying with Hardhat", 5, 400, 10800); // 3 hours duration
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
