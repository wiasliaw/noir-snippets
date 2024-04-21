import {describe, beforeAll, it, expect} from 'vitest';
import {BarretenbergBackend} from '@noir-lang/backend_barretenberg';
import {Noir} from '@noir-lang/noir_js';
import crypto from 'crypto';

import circuit from '../../../target/sha256.json';

describe('node:crypto:sha256', () => {
  let backend;
  let noir;

  beforeAll(async () => {
      backend = new BarretenbergBackend(circuit);
      noir = new Noir(circuit, backend);
  });

  it('differential', async () => {
    const data = [163, 117, 178, 149];
    const hash = crypto.createHash('sha256')
      .update(Uint8Array.from(data))
      .digest('hex');
    const result = Array.from(Buffer.from(hash, 'hex'));

    // console.log(hash)
    // console.log(result);

    const proof = await noir.generateProof({data, result});
    const verification = await noir.verifyProof(proof);
    expect(verification).true;
  }, { timeout: 100000 });
});
