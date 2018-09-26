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
    
    // Load cats from the internet
    class func loadCats(completion : @escaping (Array<Dictionary <String, String>>) -> Void) -> Void {
        let url = URL(string: "https://chenziwe.com/cats")
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET" //Receive information from server
        
        //Send out request
        let task = session.dataTask(with: request) { (data, response, error) in
           
            // If we encountered an error:
            if (error != nil) {
                print("Failed to load cats!")
                return
            }
            print("Got our cats!")
            
            // Parse data into array of dictionary to manipulate data
            let result = try? JSONSerialization.jsonObject(with: data!, options: []) as! Array<Dictionary <String, String>>
            
            // Add each cat in dictionary array to app
            completion(result!)
            
        }
        task.resume()
        sleep(10)
    }
}
