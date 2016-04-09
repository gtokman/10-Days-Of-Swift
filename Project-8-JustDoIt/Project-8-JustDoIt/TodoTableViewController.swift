//
//  TodoTableViewController.swift
//  Project-8-JustDoIt
//
//  Created by g tokman on 4/8/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import MGSwipeTableCell

@objc(TodoTableViewController)
class TodoTableViewController: UITableViewController {
    
    private var todosDatastore: TodosDatastore?
    private var todos: [Todo]?
    
    // MARK: - ViewController View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Configure
    
    func configure(todosDatastore: TodosDatastore) {
        self.todosDatastore = todosDatastore
    }
    
    // MARK: - Internal Functions
    
    private func refresh() {
        if let todosDatastore = todosDatastore {
            todos = todosDatastore.todos().sort {
                $0.dueDate.compare($1.dueDate) == NSComparisonResult.OrderedAscending
            }
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos?.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! MGSwipeTableCell
        
        // Configure the cell...
        if let todo = todos?[indexPath.row] {
            renderCell(cell, todo: todo)
            setupButtonsForCell(cell, todo: todo)
        }
        
        return cell
    }
}

// MARK: - Set up MGSipeTableCell

extension TodoTableViewController {
    private func setupButtonsForCell(cell: MGSwipeTableCell, todo: Todo) {
        cell.rightButtons = [
            
            MGSwipeButton(title: "Edit", backgroundColor: .blueColor(), padding: 30) { [weak self] sender in
                self?.editButtonPressed(todo)
                return true
            },
            MGSwipeButton(title: "Delete", backgroundColor: .redColor(), padding: 30) { [ weak self] sender in
                self?.deleteButtonPressed(todo)
                return true
            }
        ]
        cell.rightExpansion.buttonIndex = 0
        
        cell.leftButtons = [
            
            MGSwipeButton(title: "Done", backgroundColor: .greenColor(), padding: 30) { [weak self] sender in
                self?.doneButtonPressed(todo)
                return true
            }
        ]
    }
}

// MARK: - Actions

extension TodoTableViewController {
    func addButtonPressed(sender: UIButton!) {
        print("addTodoButtonPressed")
    }
    
    func editButtonPressed(todo: Todo) {
        print("editButtonPressed")
    }
    
    func deleteButtonPressed(todo: Todo) {
        todosDatastore?.deleteTodo(todo)
        refresh()
    }
    
    func doneButtonPressed(todo: Todo) {
        todosDatastore?.doneTodo(todo)
        refresh()
    }
}

// MARK: - Render TableView Cell
extension TodoTableViewController {
    private func renderCell(cell: UITableViewCell, todo: Todo) {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm dd:MM:YY"
        let dueDate = dateFormatter.stringFromDate(todo.dueDate)
        
        cell.detailTextLabel?.text = "\(dueDate) | \(todo.list.description)"
        cell.textLabel?.text = todo.description
        
        cell.accessoryType = todo.done ? .Checkmark : .None
    }
}





