//
//  ViewController.swift
//  MyCocketailBar
//
//  Created by Elisangela Pethke on 06.06.24.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var drinks = Drinks()
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        drinks.getData { error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showAlert(title: "Erro", message: error)
                } else {
                    self.navigationItem.title = "Drinks: \(self.drinks.drinkArray.count)"
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.drink = drinks.drinkArray[selectedIndexPath.row]
            
        }
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.drinkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = drinks.drinkArray[indexPath.row].strDrink
            cell.detailTextLabel?.text = "-"
            
            return cell
        }
    }
