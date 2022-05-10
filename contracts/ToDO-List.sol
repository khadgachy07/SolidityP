// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract Todo{
    address owner;
    

    /*
    Create struct called task 
    The struct has 3 fields : id,title,Completed
    Choose the appropriate variable type for each field.
    */
    struct task{
        uint id;
        string title;
        bool Completed;
    }

     ///Create a counter to keep track of added tasks
    uint taskcounter;

     /*
    create a mapping that maps the counter created above with the struct taskcount
    key should of type integer
    */
    mapping (uint => task) public tasks;

    /*
    Define a constructor
    the constructor takes no arguments
    Set the owner to the creator of the contract
    Set the counter to  zero
    */
    constructor() {
        owner = msg.sender;
        taskcounter = 0;
    }

    /*
    Define 2 events
    taskadded should provide information about the title of the task and the id of the task
    taskcompleted should provide information about task status and the id of the task
    */ 
    event taskadded(uint _id, string _title);
    event taskcompleted(uint _id, bool _Completed);

    /*
        Create a modifier that throws an error if the msg.sender is not the owner.
    */
    modifier checkOwner{ 
        require( msg.sender == owner,'Must be a owner');
        _;
    }

    /*
    Define a function called addTask()
    This function allows anyone to add task
    This function takes one argument , title of the task
    Be sure to check :
    taskadded event is emitted
     */
    function addTask(string memory _title) public checkOwner {
        taskcounter ++;
        tasks[taskcounter] = task(taskcounter,_title,false);
        emit taskadded (taskcounter,_title);
    }

     /*Define a function  to get total number of task added in this contract*/
    function countTask() public view returns(uint){
        return taskcounter;
    }

    /**
    Define a function gettask()
    This function takes 1 argument ,task id and 
    returns the task name ,task id and status of the task
     */
    function getTask(uint _id) public view returns(task memory){
        return tasks[_id];
    }

    /**Define a function marktaskcompleted()
    This function takes 1 argument , task id and 
    set the status of the task to completed 
    Be sure to check:
    taskcompleted event is emitted
     */
    function marktaskCompleted(uint _id) public {
        task memory _task = tasks[_id];
        _task.Completed = true;
        tasks[_id] = _task;
        emit taskcompleted (_id,_task.Completed);
    }
}