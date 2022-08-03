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
9. Data migration possibilities.

## Suggestions
1. Perform architectural update in several phases with Current and Future steps.

## Current plans
1. + Extract IdentityUtils
2. + Extract Migrator
3. + Extract Profile
4. Extract Migratable
5. Extract PointInitializable
6. Extract Content
7. Write more tests
9. Data migration tools update https://github.com/pointnetwork/point-contracts/blob/main/tasks/importer/social-migrator.ts

## Questions
1. It is intended to store data off-chain and we can only have hashes on-chain to check it. Is it acceptable on the current stage?
2. Needed to think how data migration issues will be solved.

## Future steps
1. Adopt Point.Social for diamond pattern - for Updatable faucet feature
    1.1 Issue: Needed to search for common well tested implementation suitable for our needs
2. Extract content storage from a smart contract to off-chain Decentralized storage. Probably only hashes should be stored in the smart contract.
    2.1 Issue: Not clear how our future off-chain decentralized storage engine will be designed.
3. Replace Ownable with OpenZeppelin AccessControl (role based access engine)
4. SmartContract versioning framework