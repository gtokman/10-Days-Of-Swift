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
       
    }
    
    // Methods
    func todos() -> [Todo] {
        return savedTodos
    }
    
    func lists() -> [List] {
        return [defaultList()] + savedLists
    }
    
}

// MARK: - Actions

extension TodosDatastore {
    func addTodo(todo: Todo) {
        print("addTodo")
        savedTodos = savedTodos + [todo]
    }
    func deleteTodo(todo: Todo?) {
        print("deleteTodo")
        if let todo = todo {
            savedTodos = savedTodos.filter({$0 != todo})
        }
    }
    
    /**Note that in order to update Todo, because all Todos are an immutable struct, we delete the previous one, and then we add a copy of it with the Boolean set to true and with doneDate set to now.*/
    func doneTodo(todo: Todo) {
        print("doneTodo")
        deleteTodo(todo)
        let doneTodo = Todo(description: todo.description, list: todo.list, dueDate: todo.dueDate, done: true, doneDate: NSDate())
        addTodo(doneTodo)
    }
    
    func addListDescription(description: String) {
        if !description.isEmpty {
            savedLists = savedLists + [List(description: description)]
        }
    }
}

// MARK: - Defaults

extension TodosDatastore {
    func defaultList() -> List {
        return List(description: "Personal")
    }
    
    func defaultDueDate() -> NSDate {
        let now = NSDate()
        let secondsInADay = NSTimeInterval(24 * 60 * 60)
        return now.dateByAddingTimeInterval(secondsInADay)
    }
}



