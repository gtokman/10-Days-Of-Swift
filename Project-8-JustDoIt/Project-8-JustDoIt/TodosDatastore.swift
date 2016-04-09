//
//  TodosDatastore.swift
//  Project-8-JustDoIt
//
//  Created by g tokman on 4/8/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

/*Create a datastore to handle all the operations of entities*/

import Foundation

class TodosDatastore {
    // Prop
    private var savedLists = [List]()
    private var savedTodos = [Todo]()
    
    
    // Init prop
    init() {
        savedLists = [
            List(description: "Personal"),
            List(description: "Work"),
            List(description: "Family")
        ]
        
        savedTodos = [
            Todo(description: "Remember the Milk",
                list: List(description: "Family") ,
                dueDate: NSDate(),
                done: false,
                doneDate: nil),
            Todo(description: "Buy Spider Man Comics",
                list: List(description: "Personal") ,
                dueDate: NSDate(),
                done: true,
                doneDate: NSDate()
            ),
            Todo(description: "Release build",
                list: List(description: "Work") ,
                dueDate: NSDate(),
                done: false,
                doneDate: nil)
        ]
    }
    
    // Methods
    func todos() -> [Todo] {
        return savedTodos
    }
    
    func lists() -> [List] {
        return savedLists
    }
    
}

// MARK: - Actions

extension TodosDatastore {
    func addTodo(todo: Todo) {
        print("addTodo")
    }
    func deleteTodo(todo: Todo?) {
        print("deleteTodo")
    }
    func doneTodo(todo: Todo) {
        print("doneTodo")
    }
}



