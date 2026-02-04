## Usage
Nbasic - ERC1155 Community Badge
Ce projet implémente un système de badges communautaires utilisant la norme ERC1155. Le contrat est évolutif, permettant au propriétaire de mettre à jour l'URI des métadonnées sans redéploiement.

## Technologies utilisées
Solidity ^0.8.24

Foundry (Forge & Cast)

OpenZeppelin (ERC1155 & Ownable)

Pinata (IPFS Storage)


## Deploy

```shell
$ forge script script/DeployNbasic.s.sol:DeployNbasic --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast --verify -vvvv
```


