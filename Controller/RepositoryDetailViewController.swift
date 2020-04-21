import UIKit

class RepositoryDetailViewController: UITableViewController { 
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var ownerNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    var repositories: RepositoryDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    func setupData() {
        let date = repositories.updated_at

        nameLbl.text = repositories.name
        dateLbl.text = date.asString()
        ownerNameLbl.text = repositories?.ownerName?.login
        descriptionLbl.text = repositories.description
    }
}