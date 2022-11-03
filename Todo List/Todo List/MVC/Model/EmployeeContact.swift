//
//  Contact.swift
//  Todo List
//
//  Created by Eapple on 02/11/2022.
//

import Foundation

class EmployeeContact: Codable {
    
    let id: String
    var name: String
    var profileImage: Data? = nil
    var contactNumber: String
    var Address: String?
    var mail: String?
    var company: String?
    var jobTitle: String?
    
    init(id: String, name: String, contactNumber: String, Address: String?, mail: String?, company: String?, jobTitle: String?) {
        self.id = id
        self.name = name
        self.contactNumber = contactNumber
        self.Address = Address
        self.mail = mail
        self.company = company
        self.jobTitle = jobTitle
    }
    
    class func getAllRecords() -> [EmployeeContact] {
        let jsonData = UserDefaults.standard.data(forKey: "EmployeeContactArray")
        if jsonData != nil {
            let record = try? JSONDecoder().decode([EmployeeContact].self, from: jsonData!)
            return record ?? [EmployeeContact]()
        }
        return [EmployeeContact]()
    }
    
    class func saveRecords(employeeContacts: [EmployeeContact]) {
        let json = try! JSONEncoder().encode(employeeContacts)
        UserDefaults.standard.set(json, forKey: "EmployeeContactArray")
    }
    
    class func deleteRecord(id : String, completion: @escaping ()->()) {
        
        var employeeContacts = getAllRecords()
        employeeContacts = employeeContacts.filter({ $0.id != id})
        saveRecords(employeeContacts: employeeContacts)
        completion()
    }
    
    class func updateRecord(employeeContact: EmployeeContact, completion: @escaping (Bool)->()) {
    
        var employeeRecords = getAllRecords()
        employeeRecords.forEach { employee in
            if employee.id == employeeContact.id {
                employee.name = employeeContact.name
                employee.contactNumber = employeeContact.contactNumber
                employee.Address = employee.Address
                employee.mail = employeeContact.mail
                employee.company = employeeContact.company
                employee.jobTitle = employeeContact.jobTitle
            }
        }
        saveRecords(employeeContacts: employeeRecords)
        completion(true)
    }
    
    class func saveRecord(newEmployeeContact: EmployeeContact, completion: @escaping (Bool)->()) {
    
        var employeeRecords = getAllRecords()
        employeeRecords.append(newEmployeeContact)
        saveRecords(employeeContacts: employeeRecords)
        completion(true)
    }
    
    class func getNewId() -> String {
        let employeeRecords = EmployeeContact.getAllRecords()
        var id = "1"
        if employeeRecords.count > 0 {
            id = employeeRecords.last?.id ?? "0"
            id = "\(Int(id)! + 1)"
        }
        return id
    }
}
