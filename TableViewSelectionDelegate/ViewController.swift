import UIKit

struct Option {
    let id: String = UUID().uuidString
    let title: String

    init(title: String) {
        self.title = title
    }
}

class ViewController: UITableViewController {
    let options = [Option(title: "Hello 1"), Option(title: "Hello 2"), Option(title: "Hello 3")]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        let option = options[indexPath.row]
        cell.textLabel?.text = option.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: DetailViewControllerDelegate {
    func detailViewControllerDidSelectTakeMeBackButton(_ detailViewController: DetailViewController) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        self.navigationController?.popViewController(animated: true)
        let option = self.options[indexPath.row]
        let alertController = UIAlertController(title: "Message", message: option.title, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

