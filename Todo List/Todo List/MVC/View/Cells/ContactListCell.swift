//
//  ContactListCell.swift
//  Todo List
//
//  Created by Eapple on 02/11/2022.
//

import UIKit

class ContactListCell: UITableViewCell {

    // MARK: - IBOutlets, Constants and Variables

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var employeeContact: EmployeeContact! {
        didSet {
            if employeeContact.profileImage == nil {
                profileLabel.text = getFirstChars(name: employeeContact.name)
            }
            name.text = employeeContact.name
            number.text = employeeContact.contactNumber
            
        }
    }
    
    // MARK: - Cell Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Methods

    class func TableViewCell(tableView: UITableView, indexPath: IndexPath) -> ContactListCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as? ContactListCell else { return ContactListCell() }
        
        return cell
    }
    
    func getFirstChars(name: String) -> String {
        
        let arr = name.components(separatedBy: " ")
        var firstCharInName = ""
        for word in arr {
            (word.first != nil && firstCharInName.count < 3) ? firstCharInName += "\(word.first!)" : nil
        }
        return firstCharInName.uppercased()
    }
}
