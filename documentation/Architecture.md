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
4. + Extract Migratable
5. + Extract PointInitializable
6. + Extract Content (PointSocial currently)
7. Write more tests
9. Data migration tools update https://github.com/pointnetwork/point-contracts/blob/main/tasks/importer/social-migrator.ts

## Questions
1. It is intended to store data off-chain and we can only have hashes on-chain to check it. Is it acceptable on the current stage?
2. Needed to think how data migration issues will be solved.
3. There is no function for likes data migration. Is it forgotten?

## Future steps
1. Adopt Point.Social for diamond pattern - for Updatable faucet feature
    1. Issue: Needed to search for common well tested implementation suitable for our needs
2. Replace Ownable with OpenZeppelin AccessControl (role based access engine)
   1. Currently, there is a different approach to set owner and migrator. With AccessControl we can replace these 2 approaches with a single one.
3. SmartContract versioning framework
4. Separate content and content metadata and make entities down->up linked instead of up->down to reduce dependencies. 
   1. Requires more significant code changes related to logic encapsulation than just refactoring. For example exclude likes related counter update from a Post entity. Exclude comments data from post etc.
   2. This approach also will reduce storage operations costs.
5. Add index to Profile entity.