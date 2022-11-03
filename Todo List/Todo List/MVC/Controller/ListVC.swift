//
//  ViewController.swift
//  Todo List
//
//  Created by Eapple on 02/11/2022.
//

import UIKit

class ListVC: UIViewController {

    // MARK: - IBOutlets, Constants and Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    var employeeContacts = [EmployeeContact] ()
    
    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ContactListCell", bundle: nil), forCellReuseIdentifier: "ContactListCell")
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        employeeContacts = EmployeeContact.getAllRecords()
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isRecordsFound()
    }
    // MARK: - Selectors
    
    // MARK: - Methods

    private func isRecordsFound() {
        if employeeContacts.isEmpty {
            self.showToast(message: "List is empty!")
        }
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate

extension ListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeContacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = ContactListCell.TableViewCell(tableView: tableView, indexPath: indexPath)
        cell.employeeContact = employeeContacts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let updateVC = storyboard?.instantiateViewController(withIdentifier: "UpdateEmployeeVC") as? UpdateEmployeeVC else { return }
        updateVC.employeeContact = employeeContacts[indexPath.row]
        self.navigationController?.pushViewController(updateVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            EmployeeContact.deleteRecord(id: self.employeeContacts[indexPath.row].id) {
                self.employeeContacts = EmployeeContact.getAllRecords()
                self.tableView.reloadData()
                self.showToast(message: "Record deleted successfully!")
            }
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
