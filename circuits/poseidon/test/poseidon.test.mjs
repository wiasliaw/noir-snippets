import {describe, beforeAll, it, expect} from 'vitest';
import {BarretenbergBackend} from '@noir-lang/backend_barretenberg';
import {Noir} from '@noir-lang/noir_js';
import { poseidon1 } from 'poseidon-lite';
import circuit from '../../../target/poseidon.json';

describe('poseidon', () => {
  let backend;
  let noir;

  beforeAll(async () => {
      backend = new BarretenbergBackend(circuit);
      noir = new Noir(circuit, backend);
  });

  it('differential', async () => {
    const data = [4];
    const result = poseidon1(data);

    const proof = await noir.generateProof({
      data: [4],
      result: `0x${result.toString(16)}`,
    });
    const verification = await noir.verifyProof(proof);
    expect(verification).true;
  }, { timeout: 100000 });
});
