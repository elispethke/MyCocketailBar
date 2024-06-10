//
//  LoginViewController.swift
//  MyCocketailBar
//
//  Created by Elisangela Pethke on 07.06.24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textRegisterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        
    }
    
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            showAlert(message: "Please enter email and password.")
            return
        }
        
        if validateUser(email: email,password: password){
            
            navigateToListViewController()
        } else {
            showAlert(message: "Pleas register")
        }
    }
    
    @IBAction func signUpButtontapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowRegister", sender: self)
    }
    
    private func validateUser(email: String, password: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let user = results.first {
                user.isLoggedIn = true
                try managedContext.save()
                return true
            }
            return false
            
        } catch {
            print("Error verifying user: \(error)")
            return false
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func navigateToListViewController() {
        performSegue(withIdentifier: "ShowList", sender: self)
    }
    
    
}


