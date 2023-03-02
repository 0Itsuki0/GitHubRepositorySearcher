//
//  ViewController.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var loader: UIAlertController = createLoader()
    
    private var repositoryList = [Repository]()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()


        // tableView delegate
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RepositoryCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: RepositoryCell.cellIdentifier)
        
        // searchBar delegate
        searchBar.delegate = self
        
        
    }


    @IBAction func onSendButtonPressed(_ sender: UIButton) {
        enterButtonPressed()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
    
}


extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.cellIdentifier, for: indexPath) as! RepositoryCell
        let repository = repositoryList[indexPath.row]
        cell.repository = repository
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: RepositoryDetailViewController.controllerIdentifier) as? RepositoryDetailViewController
            else { return }
        let repository = repositoryList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        controller.repository = repository
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


extension RepositoryListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            GitHubAPIService.taskCancel()
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        enterButtonPressed()
    }
    }




// helper function in fetch
extension RepositoryListViewController {
    
    // either enter button on the keyboard or the send button next the the search bar is pressed
    private func enterButtonPressed() {
        guard !(searchBar.text?.isEmpty ?? true)
        else {
            let alert = createAlert(title: "Please enter something!")
            presentAlert(alert: alert)
            return
        }
        searchBar.resignFirstResponder()
        
        presentAlert(alert: loader)

        if let keyword = searchBar.text{
            GitHubAPIService.fetchRepository(for: keyword) { result in
                
                DispatchQueue.main.async {
                    [weak self] in
                        guard let self = self else {return}
                    self.stopLoader(loader: self.loader)
                }
                
                switch result {
                case .success(let items):
                    self.repositoryList = items
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else {return}
                        self.tableView.reloadData()
                        if (items.count == 0) {
                            let alert = self.createAlert(title: "No matchings found!")
                            self.presentAlert(alert: alert)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else {return}
                        let alert = self.createAlert(title: error.description)
                        self.presentAlert(alert: alert)
                    }
                }
            }
        }
        return
    }
}



// loader function

extension RepositoryListViewController {
    
    func createLoader() -> UIAlertController {
        let loader = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        loader.view.addSubview(loadingIndicator)
        return loader
        
    }
            
    
    func stopLoader(loader : UIAlertController) {
        if (navigationController?.visibleViewController != loader) {
            return
        }
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }

}


// error handling with alert
extension RepositoryListViewController {
    
    private func createAlert(title: String, message: String = "") -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismissAction)
        return alert
    }
    
    private func presentAlert(alert: UIAlertController) {
        if let visibleController = self.navigationController?.visibleViewController as? UIAlertController{
            visibleController.dismiss(animated: false) {
                self.present(alert, animated: true)
            }
        }
        else {
            self.present(alert, animated: true)
        }
    }
    
}
