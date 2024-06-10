//
//  RegisterViewController.swift
//  MyCocketailBar
//
//  Created by Elisangela Pethke on 07.06.24.
//

import UIKit
import CoreData


class RegisterViewController: UIViewController {
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    var dataController = DataController(modelName: "DataModel")
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(message: "Please fill in email and password")
            return
        }
        saveUser(email: email, name: name, password: password)
        
    }
    
    
    func saveUser(email: String, name: String, password: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        let user = User(context: managedContext)
        user.email = email
        user.name = name
        user.password = password
        
        
        do {
            try managedContext.save()
            
            navigationToListController()
        } catch {
            print("Could not save \(error)")
            showAlert(message: "Error saving user")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func navigationToListController() {
        performSegue(withIdentifier: "ShowLogin", sender: self)
    }
}
