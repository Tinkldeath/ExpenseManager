//
//  ExpensesViewController.swift
//  ExpenseManager
//
//  Created by Dima on 8.11.22.
//

import UIKit

protocol CollectionViewDelegateProtocol: AnyObject & UIViewController {
    func updateView()
}

class CollectionViewController: UIViewController {
    
    private let cellTitle = "CollectionCell"
    private var items: [CollectionItem] = []
    private var viewModel: CollectionViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
        
    @IBAction func addClicked(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddExpenseViewController") as? ExpenseDetailsViewController {
            vc.setViewModel(self.viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func changeClicked(_ sender: Any) {
        self.viewModel.changeSelectionAction(self.viewModel.selection.reversed())
    }
    
}

extension CollectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.selection.toString()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellTitle, for: indexPath)
        let item = self.items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.details ?? ""
        cell.imageView?.image = UIImage(systemName: item.imageName ?? "")
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
}

extension CollectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Present details logic
    }
    
}

extension CollectionViewController: CollectionViewDelegateProtocol {
        
    func updateView() {
        self.title = self.viewModel.selection.toString()
        let image = self.viewModel.selection == .expenses ? UIImage(systemName: "tray") : UIImage(systemName: "banknote")
        self.selectionButton.setImage(image, for: .normal)
        self.configureTable()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension CollectionViewController {
    
    private func setupView() {
        self.viewModel = CollectionViewModel(delegate: self)
        self.viewModel.fetchItems()
        self.configureTable()
    }
    
    private func configureTable() {
        self.items = self.viewModel.items
    }
    
}
