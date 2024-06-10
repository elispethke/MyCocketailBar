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
    
    var drink: Drink?
    
    @IBOutlet weak var ingredientTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        
        
        guard let urlString = drink?.strDrinkThumb,
              let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            print("Error: Could not get image from url \(drink?.strDrinkThumb ?? "")")
            return
        }
        imageView.image = image
    }
    
    
}

