//
//  RegisterViewController.swift
//  MyCocketailBar
//
//  Created by Elisangela Pethke on 07.06.24.
//

import UIKit
import CoreData


class RegisterViewController: UIViewController,UITextFieldDelegate  {
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var dataController = DataController(modelName: "DataModel")
    var originalSignUpButtonBottomConstant: CGFloat = 0
    var signUpButtonBottomSpacing: CGFloat = 20
    var originalSignUpButtonYPosition: CGFloat = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordField.delegate = self
        
        originalSignUpButtonYPosition = signUpButton.frame.origin.y

               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
               view.addGestureRecognizer(tapGesture)
       
           }
   
           deinit {
               NotificationCenter.default.removeObserver(self)
           }

           @objc func hideKeyboard() {
               self.view.endEditing(true)
           }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               textField.resignFirstResponder()
               return true
           }

           @objc func keyboardWillShow(_ notification: Notification) {
               // Não é necessário ajustar nada aqui
           }

           @objc func keyboardWillHide(_ notification: Notification) {
               // Resetar a posição do botão de registro para a posição original
               signUpButton.frame.origin.y = originalSignUpButtonYPosition
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
