import { describe, beforeAll, expect, test } from 'vitest';
import {BarretenbergBackend} from '@noir-lang/backend_barretenberg';
import {Noir} from '@noir-lang/noir_js';

import circuit from '../../../target/timestamp.json';

function formatDate(date: Date) {
  return date
    .toISOString()
    .replace(/[ZT-]|:|\./g, '') // remove Z, T, :, . from string
    .split('')
    .slice(0, 14) // remove milliseconds
    .map(s => s.charCodeAt(0)) // Convert to ascii
}

describe('timestamp circuit test', () => {
  let backend: BarretenbergBackend;
  let noir: Noir;

  beforeAll(async () => {
    backend = new BarretenbergBackend(circuit);
    noir = new Noir(circuit, backend);
  });

  test('covert date string to unix time', async () => {
    const date = new Date();
    const data = formatDate(date);
    const result = Math.floor(date.getTime() / 1000);

    // proof
    const proof = await noir.generateProof({data, result});
    const verification = await noir.verifyProof(proof);
    expect(verification).true;
  }, { timeout: 100000 });
});
