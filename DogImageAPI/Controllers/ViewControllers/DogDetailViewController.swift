//
//  DogDetailViewController.swift
//  DogImageAPI
//
//  Created by Lizzie Ferguson on 5/5/21.
//

import UIKit

class DogDetailViewController: UIViewController {
   
    //MARK: Outlets
    @IBOutlet weak var dogSearchTextField: UITextField!
    @IBOutlet weak var dogImageView: UIImageView!
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: Properties
    
    var dog: Dog?
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let searchTerm = dogSearchTextField.text, !searchTerm.isEmpty else {return}
        DogController.fetchRandomDogImage(with: searchTerm.lowercased()) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let dog):
                    self.fetchImage(from: dog)
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    
    //MARK: Helper Methods
    func updateViews(with image: UIImage) {
        dogImageView.image = image
    }
    
    func fetchImage(from dog: Dog) {
        DogController.fetchImageForDog(with: dog) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let image):
                    self.updateViews(with: image)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
            
    }
    
}//End of class

