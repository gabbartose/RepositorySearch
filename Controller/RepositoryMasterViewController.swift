import UIKit

class RepositoryMasterViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    var listOfRepositories = [RepositoryDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfRepositories.count) Repositories found"
            }
        }
    }

    let identifier: "RepositoryCell"
    let created

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRepositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let repository = listOfRepositories[indexPath.row]

        let date = repository.updated_at

        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = date.asString()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repositoryDetailViewController = RepositoryMasterViewController()
        
        repositoryDetailViewController.repositories = listOfRepositories[indexPath.row]
        print("You tapped cell number \(indexPath.row).")
        
        self.navigationController?.pushViewController(repositoryDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension RepositorySearchMasterViewController: UISearchBarDelegate {
    func searchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let repositoryRequest = Repository(searchString: searchBarText)
        repositoryRequest.getRepositories { [weak self]  result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let repositories):
                    self?.listOfRepositories = repositories
            }
        }
    }
}