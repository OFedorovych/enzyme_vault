import type { YearnVaultV2AdapterArgs } from '@enzymefinance/protocol';
import type { DeployFunction } from 'hardhat-deploy/types';

import { isOneOfNetworks, Network } from '../../../../utils/helpers';

const fn: DeployFunction = async function (hre) {
  const {
    deployments: { deploy, get },
    ethers: { getSigners },
  } = hre;

  const deployer = (await getSigners())[0];
  const integrationManager = await get('IntegrationManager');
  const yearnVaultV2PriceFeed = await get('YearnVaultV2PriceFeed');

  await deploy('YearnVaultV2Adapter', {
    args: [integrationManager.address, yearnVaultV2PriceFeed.address] as YearnVaultV2AdapterArgs,
    from: deployer.address,
    linkedData: {
      nonSlippageAdapter: true,
      type: 'ADAPTER',
    },
    log: true,
    skipIfAlreadyDeployed: true,
  });
};

fn.tags = ['Release', 'Adapters', 'YearnVaultV2Adapter'];
fn.dependencies = ['IntegrationManager', 'YearnVaultV2PriceFeed'];

fn.skip = async (hre) => {
  const chain = await hre.getChainId();

  return !isOneOfNetworks(chain, [Network.HOMESTEAD]);
};

export default fn;
