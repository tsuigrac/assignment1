import UIKit

class Cat: NSObject {
    
    struct CatCellInfo {
        // Cat characteristics
        let name : String!
        let image: UIImage!
        let age: Int!
        let breed: String!
    }
    
    // Number of cats we own
    static var count : Int = 0
    
    // List of cats
    static var catArr = [CatCellInfo]()
    
    // Method to add cats to array
    class func addCat(name : String!, image: UIImage!, age: Int!, breed: String!) -> Void {
        
        // Create a new cat
        let newCat = CatCellInfo(name: name, image: image, age: age, breed: breed)
        
        // Append new cat to the array
        catArr.append(newCat)
        
        count += 1
    }
}
