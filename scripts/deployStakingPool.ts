 import {ethers} from "hardhat";


async function main() {
    


    const token1 = await ethers.getContractFactory('TokenA')
    const tk1 = await token1.deploy()
    await tk1.waitForDeployment
    

    const token2 = await ethers.getContractFactory('TokenB')
    const tk2 = await token2.deploy()
    await tk2.waitForDeployment

    const staking = await ethers.getContractFactory('StakingReward')
    const st = await staking.deploy(tk1.target,tk2.target)
    await st.waitForDeployment

    const staking2 = await ethers.getContractFactory('EtherStaker')
    const st2 = await staking2.deploy()
    await st2.waitfordeployment

   
    console.log(`TokenA deployed to: ${tk1.target}`);
    console.log(`TokenB deployed to: ${tk2.target}`);
    console.log(`StakingReward deployed to: ${st.target}`);
    console.log(`EtherStaker deployed to: ${st2.target}`);

    
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
