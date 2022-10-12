// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Abilities[] ability;
    Type[] types;
    Weakness[] weaknesses;
  }
  struct Weakness{
    string name;
  }

  struct Type{
    string name;
  }

  struct Abilities{
    string nameAbility;
    string description;
  }

  event eventNewPokemon(uint id, string name);

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;

  function createPokemon (string memory _name, uint _id, string memory _nameAbility, string memory _description, string memory _weaknessName, string memory _typeName) public {
        require(_id > 0 , "Add a pokemon with id greater than 0");
        require( bytes(_name).length > 2 || bytes(_name).length == 0, "Insert a name greater than 2 characters");
        pokemons.push();
        uint _index = pokemons.length -1;
        pokemons[_index].id = _index;
        pokemons[_index].name = _name;
        addAbility(_index, _nameAbility, _description);
        addType(_index, _typeName);
        addWeakness(_index, _weaknessName);
        pokemonToOwner[_index] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id, _name);
    }

    function addAbility(uint _id, string memory _nameAbility, string memory _description) public  {
     pokemons[_id].ability.push(Abilities(_nameAbility, _description));
    }
    
    function addType(uint _id, string memory _typeName) public {
    pokemons[_id].types.push(Type(_typeName));
    }
  
   function addWeakness(uint _id, string memory _weaknessName) public {
    pokemons[_id].weaknesses.push(Weakness(_weaknessName));
    }
   
   function getAllPokemons() public view returns (Pokemon[] memory) {
     return pokemons;
    }



}
