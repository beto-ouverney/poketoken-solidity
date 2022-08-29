pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PokeToken is ERC721 {

    struct Pokemon {
        string name;
        string typePoke;
        uint level;
        uint hp;
        uint attack;
        uint defense;
        string img;
    }

    Pokemon[] public pokemons;
    address public owner;

    constructor() ERC721("POKETOKEN", "PKT") {
      owner = msg.sender;
    }

    modifier onlyOwnerOf(uint _monsterId) {
       require(ownerOf(_monsterId) == msg.sender);
    }

    function battle(uint _attackingPokemon, unit _defendingPokemon) public {
        Pokemon storage attackingPokemon = pokemons[_attackingPokemon];
        Pokemon storage defendingPokemon = pokemons[_defendingPokemon];
        uint attackingPower = attackingPokemon.attack * attackingPokemon.level;
        uint defendingPower = defendingPokemon.defense * defendingPokemon.level;
        int damage = attackingPower - defendingPower;
        if (damage > 0) {
            pokemons[_defendingPokemon].hp -= damage;
        }else {
            pokemons[_attackingPokemon].hp -= 1;
        }
    }


 function randomNumber(uint number) private view returns (uint) {
        return (uint(keccak256
        (abi.encodePacked(block.timestamp,number))) % number);
    }

    function createNewPokemon(string memory _name, string memory typePoke, address _to, string memory _img) public {
          require(msg.sender == owner, "Only the owner can create new pokemons");
          unit attack = randomNumber(100);
          unit defense = randomNumber(100);
          unit level = randomNumber(10);
          uint newId = pokemons.length;// newId is the index of the new pokemon
          pokemons.push(Pokemon(_name, typePoke, level, 100, attack, defense, _img));
          _safeMint(_to, newId);

}

}