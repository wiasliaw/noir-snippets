# sha256

## function signature

```noir
pub fn sha256<N>(input: [u8; N]) -> [u8; 32]
```

## differential test

- [node:crypto:createHash](https://nodejs.org/docs/latest/api/crypto.html#cryptocreatehashalgorithm-options)
- [@noble/hashes](https://github.com/paulmillr/noble-hashes)
