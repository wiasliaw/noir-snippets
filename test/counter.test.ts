import { createAccount, getDeployedTestAccountsWallets } from '@aztec/accounts/testing';
import {
  AccountWallet,
  PXE,
  createPXEClient,
  waitForPXE,
} from '@aztec/aztec.js';
import { CounterContract } from '../artifacts/Counter.js';

describe("Counter", () => {
  let pxe: PXE;
  let owner: AccountWallet;
  let counter: CounterContract;

  beforeAll(async () => {
    pxe = createPXEClient("http://localhost:8080");
    await waitForPXE(pxe);
  });

  beforeEach(async () => {
    owner = await createAccount(pxe);
    counter = await CounterContract.deploy(owner)
      .send()
      .deployed();
  }, 60_000);

  test('test value()', async () => {
    // https://github.com/Swatinem/rollup-plugin-dts/issues/156
    expect(await counter.methods.value().view()).toEqual(0n);
  });

  test('test increment()', async () => {
    await counter.methods.increment().send().wait();
    expect(await counter.methods.value().view()).toEqual(1n);
  }, 30_000);

  test('test decrement()', async () => {
    await counter.methods.increment().send().wait();
    expect(await counter.methods.value().view()).toEqual(1n);
    await counter.methods.decrement().send().wait();
    expect(await counter.methods.value().view()).toEqual(0n);
  }, 60_000);
});