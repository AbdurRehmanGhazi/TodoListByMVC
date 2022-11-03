//
//  AddEmployeeVC.swift
//  Todo List
//
//  Created by Eapple on 02/11/2022.
//

import UIKit

class AddEmployeeVC: UIViewController {

    // MARK: - IBOutlets, Constants and Variables
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var jobTitle: UITextField!

    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardOnBackgroundTap()
    }
    
    // MARK: - Selectors
    
    // MARK: - IBActions

    @IBAction func tapAddButton(_ sender: UIButton) {
       
        if ifValide() {
         
            let newRecord = EmployeeContact(id: EmployeeContact.getNewId(), name: name.text!, contactNumber: number.text!, Address: address.text, mail: mail.text, company: company.text, jobTitle: jobTitle.text)
            
            EmployeeContact.saveRecord(newEmployeeContact: newRecord) { success in
                if success {
                    self.tabBarController?.selectedIndex = 0
                    self.showToast(message: "Record Save Successfully!")
                }
                else {
                    self.showToast(message: "Record Not Save!")
                }
            }
        }
        else {
            self.showToast(message: "Complete all fields first!")
        }
    }
    
    
    // MARK: - Methods
    
    private func ifValide() -> Bool {
        
        if !name.text!.isEmpty && !number.text!.isEmpty && !address.text!.isEmpty && !mail.text!.isEmpty && !company.text!.isEmpty && !jobTitle.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
}
