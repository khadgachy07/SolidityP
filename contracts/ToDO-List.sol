// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract Todo{
    address owner;

    struct task{
        uint id;
        string title;
        bool Completed;
    }

    uint taskcounter;

    mapping (uint => task) public tasks;

    constructor() {
        owner = msg.sender;
        taskcounter = 0;
    }

    event taskadded(uint _id, string _title);
    event taskcompleted(uint _id, bool _Completed);

    modifier checkOwner{ 
        require( msg.sender == owner,'Must be a owner');
        _;
    }

    function addTask(string memory _title) public checkOwner {
        taskcounter ++;
        tasks[taskcounter] = task(taskcounter,_title,false);
        emit taskadded (taskcounter,_title);
    }

    function countTask() public view returns(uint){
        return taskcounter;
    }

    function getTask(uint _id) public view returns(task memory){
        return tasks[_id];
    }

    function marktaskCompleted(uint _id) public {
        task memory _task = tasks[_id];
        _task.Completed = true;
        tasks[_id] = _task;
        emit taskcompleted (_id,_task.Completed);
    }
}