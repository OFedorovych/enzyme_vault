import type { AllowedAdaptersPerManagerPolicyArgs } from '@enzymefinance/protocol';
import type { DeployFunction } from 'hardhat-deploy/types';

const fn: DeployFunction = async function (hre) {
  const {
    deployments: { deploy, get },
    ethers: { getSigners },
  } = hre;

  const deployer = (await getSigners())[0];
  const addressListRegistry = await get('AddressListRegistry');
  const policyManager = await get('PolicyManager');

  await deploy('AllowedAdaptersPerManagerPolicy', {
    args: [policyManager.address, addressListRegistry.address] as AllowedAdaptersPerManagerPolicyArgs,
    from: deployer.address,
    linkedData: {
      type: 'POLICY',
    },
    log: true,
    skipIfAlreadyDeployed: true,
  });
};

fn.tags = ['Release', 'Policies', 'AllowedAdaptersPerManagerPolicy'];
fn.dependencies = ['AddressListRegistry', 'PolicyManager'];

export default fn;
