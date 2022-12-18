//
//  AddExpenseViewController.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import UIKit

class ExpenseDetailsViewController: UIViewController {
    
    private var categories: [CollectionItem] = []
    private var viewModel: CollectionViewModelProtocol!
    private var selectedRow: Int? = nil
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var watermarkField: UITextField!
    @IBOutlet weak var sumField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.changeSelectionAction(.expenses)
    }
    
    func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func setViewModel(_ viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        self.categories = self.viewModel.items
    }
    
    
    @IBAction func submitClicked(_ sender: Any) {
        guard let data = self.generateData() else { return }
        let action = UserAction(action: .create, data: data)
        self.viewModel.userAction(action)
    }
    
}

extension ExpenseDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row].categoryName
        cell.imageView?.image = UIImage(systemName: self.categories[indexPath.row].imageName ?? "")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
}

extension ExpenseDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 0{
            self.selectedRow = nil
        }else {
            self.selectedRow = indexPath.row
        }
    }
}

extension ExpenseDetailsViewController {
    
    private func generateData() -> ExpenseData? {
        let category = self.selectedRow != nil ? self.categories[self.selectedRow!] : nil
        print(Date())
        return ExpenseData(
            id: UUID().uuidString,
            title: titleField.text ?? "",
            watermark: watermarkField.text,
            sum: Double(sumField.text ?? "") ?? -1,
            category: category?.title ?? "None",
            date: Date()
        )
    }
    
}
