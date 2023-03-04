//
//  RepositoryListViewController.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy private var loader: UIAlertController = createLoader()
    
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
        keywordEntered()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
}


// tableView delegate methods
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


// searchBar delegate methods
extension RepositoryListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keywordEntered()
    }
    
}


// helper function in fetching repositories
extension RepositoryListViewController {
    
    private func keywordEntered() {
        
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            let alert = createAlert(title: "Please enter something!")
            presentAlert(alert: alert)
            return
        }
        
        searchBar.resignFirstResponder()
        presentAlert(alert: loader)

        Task {
            do {
                self.repositoryList = try await GitHubAPIService.fetchRepository(for: text)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.stopLoader(loader: self.loader)
                    self.tableView.reloadData()
                }
            } catch (let error as GitHubAPIService.ServiceError){
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    self.stopLoader(loader: self.loader)
                    let alert = self.createAlert(title: error.description)
                    self.presentAlert(alert: alert)
                }
            }
        }
    }
    
}



// helper function in showing alerts
extension RepositoryListViewController {
    
    private func createLoader() -> UIAlertController {
        let loader = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        loader.view.addSubview(loadingIndicator)
        return loader
        
    }
    
    
    private func stopLoader(loader : UIAlertController) {
        if (navigationController?.visibleViewController != loader) {
            return
        }
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }

    
    private func createAlert(title: String, message: String = "") -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismissAction)
        return alert
    }
  
    
    private func presentAlert(alert: UIAlertController) {
        if let visibleController = self.navigationController?.visibleViewController as? UIAlertController{
            visibleController.dismiss(animated: false) { [weak self] in
                guard let self = self else {return}
                self.present(alert, animated: true)
            }
        }
        else {
            self.present(alert, animated: true)
        }
    }
    
}
