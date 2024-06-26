compile:
  @aztec-nargo compile

codegen:
  @aztec-cli codegen ./target/public_counter-Counter.json -o artifacts --ts

clean:
  rm -rf artifacts target codegenCache.json

test:
  @pnpm run test
