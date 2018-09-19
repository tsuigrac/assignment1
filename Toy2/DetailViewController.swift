import UIKit

class DetailViewController: UIViewController {

    var name : String! = ""
    var age : String! = ""
    var breed : String! = ""
    var image : UIImage!
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set characteristic labels for cat
        nameLabel.text = name
        ageLabel.text = age + " year(s) old"
        breedLabel.text = breed
        catImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
