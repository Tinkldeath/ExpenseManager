//
//  ExpensesViewController.swift
//  ExpenseManager
//
//  Created by Dima on 8.11.22.
//

import UIKit

class ExpensesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var journal: ExpenseJournal!
    private var model: TableModel = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }
    
    
    @IBAction func addClicked(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddExpenseViewController") as? AddExpenseViewController {
            vc.setJournal(self.journal)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ExpensesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let index = self.model.indexForSection(section)
        return self.model.keys[index]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)
        let value = self.model.valueFor(indexPath.section, indexPath.row)
        cell.textLabel?.text = value.titleOrWatermark
        cell.detailTextLabel?.text = value.sum
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.keys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.model.keyForSection(section)
        return self.model[key]?.count ?? 0
    }
}

extension ExpensesViewController: UITableViewDelegate {
    
}

extension ExpensesViewController {
    
    func setup() {
        self.journal = ExpenseJournal()
        self.model = self.journal.tableModel()
    }
    
    func updateView() {
        self.tableView.reloadData()
    }
    
}
