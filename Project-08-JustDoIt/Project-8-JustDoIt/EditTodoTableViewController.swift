//
//  EditTodoTableViewController.swift
//  Project-8-JustDoIt
//
//  Created by g tokman on 4/9/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

enum EditTableViewRow: Int {
    case Description
    case List
    case DueDate
    case Done
    case DatePicker
}

class EditTodoTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var descriptionTextField: UITextField?
    @IBOutlet var listLabel: UILabel?
    @IBOutlet var dueDateLabel: UILabel?
    @IBOutlet var dueDatePicker: UIDatePicker?
    
    var todoToEdit: Todo?
    var todosDatastore: TodosDatastore?
    private var list: List?
    private var dueDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        refresh()
        descriptionTextField?.becomeFirstResponder()
    }
}

private extension EditTodoTableViewController {
    func setup() {
        if let todo = todoToEdit {
            descriptionTextField?.text = todo.description
            list = todo.list
            dueDate = todo.dueDate
        } else if let todosDatastore = todosDatastore {
            list = todosDatastore.defaultList()
            dueDate = todosDatastore.defaultDueDate()
        }
        datePickerSetup()
    }
    
    func datePickerSetup() {
        dueDatePicker?.datePickerMode = .DateAndTime
        dueDatePicker?.minimumDate = NSDate()
        dueDatePicker?.date = dueDate!
        dueDatePicker?.addTarget(self, action: #selector(EditTodoTableViewController.dueDateChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    @objc func dueDateChanged(sender: UIButton!) {
        dueDate = dueDatePicker?.date
        refresh()
    }
    
    func refresh() {
        listLabel?.text = "List: \(list!.description)"
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "hh:mm dd-MM-YY"
        if let dueDate = dueDate {
            let formattedDueDate = dateFormatter.stringFromDate(dueDate)
            dueDateLabel?.text = "Due date: \(formattedDueDate)"
        }
    }
    
    func doneSelected() {
        if let descriptionText = descriptionTextField?.text, list = list, dueDate = dueDate where !descriptionText.isEmpty {
            let newTodo = Todo(description: descriptionText, list: list, dueDate: dueDate, done: false, doneDate: nil)
            todosDatastore?.addTodo(newTodo)
            todosDatastore?.deleteTodo(todoToEdit)
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    func showAddList() {
        performSegueWithIdentifier("AddList", sender: self)
    }
}

// MARK: - Table View Delegate

extension EditTodoTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch EditTableViewRow(rawValue: indexPath.row)! {
        case .List:
            showAddList()
        case .DueDate:
            descriptionTextField?.resignFirstResponder()
        case .Done:
            doneSelected()
        default:
            break
        }
    }
}

// MARK: - Segue

extension EditTodoTableViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier, destinationViewController = segue.destinationViewController as? ListTableViewController else {
            return
        }
        
        if identifier == "AddList" {
            destinationViewController.title = "Lists"
            destinationViewController.todosDatastore = todosDatastore
            destinationViewController.onListSelected = { list in
                self.list = list
                self.refresh()
            }
        }
    }
}











