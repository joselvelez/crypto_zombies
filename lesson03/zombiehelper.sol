pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns (uint[] memory) {

        // create a fixed size array given ownerZombieCount value
        uint[] memory result = new uint[](ownerZombieCount[_owner]);

        // keep track of the index in the result array
        // we cannot push onto an array stored in memory
        uint counter = 0;

        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                // add index of current zombie to results array
                result[counter] = i;
                // increment counter to next empty index in results array
                counter++;
            }
        }

        return result;
    }

}