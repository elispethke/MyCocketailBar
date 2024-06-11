//
//  DetailViewController.swift
//  MyCocketailBar
//
//  Created by Elisangela Pethke on 06.06.24.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var recipeTextField: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var drink: Drink?
    
    @IBOutlet weak var ingredientTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        if drink == nil {
            drink = Drink()
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        drinkLabel.text = drink?.strDrink
        alcoholLabel.text = drink?.strAlcoholic == "Alcoholic" ? "Yes" : "NO"
        glassLabel.text = drink?.strGlass
        recipeTextField.text = drink?.strInstructions
        
        guard let urlString = drink?.strDrinkThumb, let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                    }
                } else {
                    throw NSError(domain: "ImageErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not create image from data"])
                }
            } catch {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    let alert = UIAlertController(title: "Error", message: "Could not get image from url \(self.drink?.strDrinkThumb ?? "")", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

