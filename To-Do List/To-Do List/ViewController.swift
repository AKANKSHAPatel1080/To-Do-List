//
//  ViewController.swift
//  To-Do List
//
//  Created by Akanksha Patel on 11/01/24.
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert  = UIAlertController(title: "Add New Item", message: "Enter new to-do list item!", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter items..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler:  { (_) in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                currentItems.append(text)
                UserDefaults.standard.set(currentItems, forKey: "items")
                self.items = currentItems
                self.table.reloadData()
            }
        }))
        present(alert, animated: true, completion: nil)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
