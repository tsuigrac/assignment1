import UIKit

var age : Int = -1
var name : String = ""
var breed : String = ""
var rowSelected : Int = 0

class AddCatTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var addCatViewController : AddCatViewController? = nil

    @IBOutlet weak var TextView: UITextView!
    
    @IBOutlet weak var PickerView: UIPickerView!
    
    //Enable done button if fields are filled
    func canSubmit() -> Bool {
        return age != -1 && name != "" && breed != ""
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PickerView.delegate = self
        PickerView.dataSource = self
        TextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Picker View Methods
    
    //Number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    //Set ages to scroll through
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Return the row number as a string
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        age = row
        rowSelected = row
        //Reload the 2nd section in table view
        addCatViewController?.TableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        //Enable done button if fields are filled
        if (canSubmit()) {
            addCatViewController?.DoneButton.isEnabled = true
        }
    }
    
    // MARK: - Text View Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //Clean out text when user editing default cell
        if (textView.textColor == UIColor.gray) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    // Change value of variables if user edited, otherwise remain empty
    func textViewDidChange(_ textView: UITextView) {
        if (textView.tag == 0) {
            name = textView.text
        }
        else {
            breed = textView.text
        }
        if (canSubmit()) {
            addCatViewController?.DoneButton.isEnabled = true
        }
        else {
            addCatViewController?.DoneButton.isEnabled = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //If user did not enter any data, reset to default
        if (textView.text == "") {
            if (textView.tag == 0) {
                textView.text = "Name"
            }
            else {
                textView.text = "Type"
            }
        textView.textColor = UIColor.gray
        }
    }
}
