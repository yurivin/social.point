# Point.Social Architecture

## Requirements

1. Reduce the amount of local storage for the contract.
2. Reduce the amount of the contract code because it has limits related to blockc size.
3. In future releases we should migrate storage to offchain decentralized file storage, so it is good to isolate content access intefaces.
4. Make it possible to add new functionality without updating the whole Point.Social
5. Separate new contracts addition and activation.
6. Make it possible to reconfigure all needed contracts for the new version in one transaction not to have inconsistent state and functions.
7. Make it possible to downgrade smart contracts suite.
8. Extract more general Point network libraries and more specific point social libraries.

## Questions
1. It is intended to store data ofchain and we can only have hases onchain to check it. Is it acceptable on the current stage?