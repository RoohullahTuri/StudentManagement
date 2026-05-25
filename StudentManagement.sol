// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    Student Management Smart Contract

    Features:
    - Add new student records
    - Update existing student records
    - Retrieve student information
    - Validate whether a student exists

    Developed for educational purposes using Solidity.
*/

contract StudentManagement {

    // Structure to store student information
    struct Student {
        uint256 id;
        string name;
        uint256 age;
        string department;
        bool exists;
    }

    // Mapping to store students using student ID
    mapping(uint256 => Student) private students;

    // Event emitted when a student is added
    event StudentAdded(
        uint256 indexed id,
        string name,
        uint256 age,
        string department
    );

    // Event emitted when a student is updated
    event StudentUpdated(
        uint256 indexed id,
        string name,
        uint256 age,
        string department
    );

    /*
        Function: addStudent
        Purpose : Adds a new student record

        Requirements:
        - Student ID must not already exist
    */
    function addStudent(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _department
    ) public {

        require(!students[_id].exists, "Student already exists");

        students[_id] = Student({
            id: _id,
            name: _name,
            age: _age,
            department: _department,
            exists: true
        });

        emit StudentAdded(_id, _name, _age, _department);
    }

    /*
        Function: updateStudent
        Purpose : Updates an existing student's information

        Requirements:
        - Student must already exist
    */
    function updateStudent(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _department
    ) public {

        require(students[_id].exists, "Student does not exist");

        Student storage student = students[_id];

        student.name = _name;
        student.age = _age;
        student.department = _department;

        emit StudentUpdated(_id, _name, _age, _department);
    }

    /*
        Function: getStudent
        Purpose : Retrieves student information

        Requirements:
        - Student must exist
    */
    function getStudent(uint256 _id)
        public
        view
        returns (
            uint256,
            string memory,
            uint256,
            string memory
        )
    {

        require(students[_id].exists, "Student does not exist");

        Student memory student = students[_id];

        return (
            student.id,
            student.name,
            student.age,
            student.department
        );
    }

    /*
        Function: studentExists
        Purpose : Checks whether a student exists
    */
    function studentExists(uint256 _id)
        public
        view
        returns (bool)
    {
        return students[_id].exists;
    }
}