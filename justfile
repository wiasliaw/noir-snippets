compile:
  @aztec-nargo compile

codegen:
  @aztec-cli codegen ./target/counter-Counter.json -o artifacts --ts

test:
  @pnpm run test