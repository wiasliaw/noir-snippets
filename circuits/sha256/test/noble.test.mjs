import {describe, beforeAll, it, expect} from 'vitest';
import {BarretenbergBackend} from '@noir-lang/backend_barretenberg';
import {Noir} from '@noir-lang/noir_js';
import {sha256} from '@noble/hashes/sha256';

import circuit from '../../../target/sha256.json';

describe('@noble/hashes/sha256', () => {
  let backend;
  let noir;

  beforeAll(async () => {
      backend = new BarretenbergBackend(circuit);
      noir = new Noir(circuit, backend);
  });

  it('differential', async () => {
    const data = [163, 117, 178, 149];
    const hash = sha256(new Uint8Array(data));
    const result = Array.from(hash);

    // console.log(Buffer.from(hash).toString('hex'));
    // console.log(result);

    const proof = await noir.generateProof({data, result});
    const verification = await noir.verifyProof(proof);
    expect(verification).true;
  }, { timeout: 100000 });
});
