//
//  UpdateViewController.swift
//  Todo List
//
//  Created by Eapple on 02/11/2022.
//

import UIKit

class UpdateEmployeeVC: UIViewController {
    
    // MARK: - IBOutlets, Constants and Variables

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var jobTitle: UITextField!

    var employeeContact: EmployeeContact?
    
    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDataInLayout()
        hideKeyboardOnBackgroundTap()
    }
    
    // MARK: - Selectors
    
    // MARK: - IBActions

    @IBAction func tapUpdateButton(_ sender: UIButton) {
       
        if ifValide() {
            
            let updatedRecord = EmployeeContact(id: employeeContact!.id, name: name.text!, contactNumber: number.text!, Address: address.text, mail: mail.text, company: company.text, jobTitle: jobTitle.text)
            
            EmployeeContact.updateRecord(employeeContact: updatedRecord) { success in
                if success {
                    self.navigationController?.popViewController(animated: true)
                    self.showToast(message: "Record Update Successfully!")
                }
                else {
                    self.showToast(message: "Record Not Update!")
                }
                
            }
        }
        else {
            self.showToast(message: "Complete all fields first!")
        }
    }
    
    // MARK: - Methods
    
    private func setDataInLayout() {
        
        name.text = employeeContact?.name
        number.text = employeeContact?.contactNumber
        address.text = employeeContact?.Address
        mail.text = employeeContact?.mail
        company.text = employeeContact?.company
        jobTitle.text = employeeContact?.jobTitle
    }
    
    private func ifValide() -> Bool {
        
        if !name.text!.isEmpty && !number.text!.isEmpty && !address.text!.isEmpty && !mail.text!.isEmpty && !company.text!.isEmpty && !jobTitle.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
}
