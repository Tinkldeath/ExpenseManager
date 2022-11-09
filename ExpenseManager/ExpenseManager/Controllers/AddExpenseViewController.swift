//
//  AddExpenseViewController.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    private var journal: ExpenseJournal?
    private var categories: [CategoryModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
    
    func setJournal(_ journal: ExpenseJournal) {
        self.journal = journal
    }
    
    func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.categories = self.journal?.categoriesModel() ?? []
    }
    
}

extension AddExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row].title
        cell.imageView?.image = UIImage(systemName: self.categories[indexPath.row].image ?? "")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
}

extension AddExpenseViewController: UITableViewDelegate {
    
}
