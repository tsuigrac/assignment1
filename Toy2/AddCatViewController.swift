import UIKit

class AddCatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var isPickerViewOpened : Bool = false
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    @IBAction func DoneButtonTapped(_ sender: Any) {
        
        //Create and add a cat with the corresponding name and breed
        Cat.addCat(name: name, image: #imageLiteral(resourceName: "cat3"), age: age, breed: breed)
        
        //Reset to default for next cats
        name = " "
        breed = " "
        age = -1
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ClearButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        //Disable done button if no editing has been done
        DoneButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 2
        }
        // Two rows if the picker view is opened
        else {
            if (isPickerViewOpened) {
                return 2
            }
            else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCatCell", for: indexPath) as! AddCatTableViewCell
        
        //Assign row number to cell text view
        cell.TextView.tag = indexPath.row
            
        // Configurate cell appearance
        cell.TextView.textContainer.maximumNumberOfLines = 1
        cell.TextView.textContainer.lineBreakMode = .byTruncatingTail
        cell.PickerView.isHidden = true
        
        //First section
        if (indexPath.section == 0) {
            cell.TextView.isEditable = true
            cell.TextView.textColor = UIColor.gray
            cell.TextView.isScrollEnabled = false
            
            // Set header rows
            if (indexPath.row == 0) {
                cell.TextView.text = "Name"
            }
            else {
                cell.TextView.text = "Type"
            }
        }
        //Second section
        else {
            if (indexPath.row == 0) {
                cell.TextView.textColor = UIColor.black
                cell.TextView.isEditable = false
                cell.TextView.isSelectable = false
                cell.TextView.isUserInteractionEnabled = false
                cell.TextView.isHidden = false
                
                // Display default
                if ( age == -1 ) {
                    cell.TextView.text = "Age"
                }
                // Display formatted age by user edit
                else {
                    cell.TextView.text = "Age " + String(age)
                }
                
            }
            else {
                // Expandable cell
                cell.PickerView.isHidden = false
                cell.TextView.isHidden = true
            }
        }
        
        cell.addCatViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 50
        }
        else {
            //First row in second section should have same height
            if (indexPath.row == 0) {
                return 50
            }
            else {
                //Expandable cell is taller
                return 150
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open/close picker view when expandable cell is selected
        if (indexPath.section == 1 && indexPath.row == 0) {
            if (isPickerViewOpened) {
                isPickerViewOpened = false
            }
            else {
                isPickerViewOpened = true
            }
        // Reload second section to toggle picker view
        tableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
            }
    }
}
