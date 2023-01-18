//
//  BitacoraDetailsViewController.swift
//  BitacorAPP
//
//  Created by Dragon on 12/01/23.
//
//  Mantained by Alan Badillo Salas
//
//  Changes:
//  * [12/01/23] Definition of BitacoraDetailsViewController class
//

import UIKit

class BitacoraDetailsViewController: UIViewController {

    weak var viewModel: BitacoraDetailsViewModel?
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var statusLabelTextField: UITextField!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusSelectMenu: UIMenu!
    
    @IBOutlet weak var statusTableView: UITableView!
    
    var status: String?
    
    var statusOfSelectedBitacora: [BitacoraStatusEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavbarItem()
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel?.refreshBitacoraSelected()
        self.viewModel?.refreshStatusOfBitacoraSelected(status: nil)
    }
    
    func setupNavbarItem() {
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveSelector))
        
        self.navigationItem.title = "Bitacora Details"
        self.navigationItem.setRightBarButton(saveItem, animated: true)
    }
    
    func setupTableView() {
        self.statusTableView.dataSource = self
        //self.statusTableView.delegate = self
    }
    
    @objc func saveSelector() {
        
        var title: String?
        var details: String?
        
        if let text = self.titleTextField.text {
            if !text.isEmpty {
                title = text
            }
        }
        
        if let text = self.detailsTextView.text {
            if !text.isEmpty {
                details = text
            }
        }
        
        self.viewModel?.updateBitacora(title: title, details: details)
        
    }
    
    @IBAction func statusSelectAction(_ sender: Any) {
        let selectStatusActionSheet = UIAlertController(title: "Select status", message: "Select any status", preferredStyle: .actionSheet)
        
        selectStatusActionSheet.addAction(UIAlertAction(title: "Visited", style: .default, handler: { _ in
            self.status = "VISITED"
            self.statusLabel.text = "Status: \(self.status ?? "Not selected")"
        }))
        
        selectStatusActionSheet.addAction(UIAlertAction(title: "Closed", style: .default, handler: { _ in
            self.status = "CLOSED"
            self.statusLabel.text = "Status: \(self.status ?? "Not selected")"
        }))
        
        self.present(selectStatusActionSheet, animated: true)
    }
    
    @IBAction func statusAddAction(_ sender: Any) {
        
        guard let label = self.statusLabelTextField.text else {
            return
        }
        
        guard !label.isEmpty else {
            return
        }
        
        guard let status = self.status else {
            return
        }
        
        print("Add status: \(label) \(status)")
        
        self.viewModel?.addStatusInSelectedBitacora(label: label, status: status)
        
    }
    
    @IBAction func screenshotAction(_ sender: Any) {
    }
    
}

extension BitacoraDetailsViewController: BitacoraDetailsView {
    
    func bitacora(bitacoraSelected bitacora: BitacoraEntity) {
        self.idLabel.text = "#\(bitacora.id)"
        self.titleTextField.text = bitacora.title
        self.detailsTextView.text = bitacora.details
    }
    
    func bitacora(statusOfBitacoraSelected status: [BitacoraStatusEntity]) {
        
        self.status = nil
        self.statusLabelTextField.text = ""
        self.statusLabel.text = "Status: (Not selected)"
        
        self.statusOfSelectedBitacora = status
        self.statusTableView.reloadData()
    }
    
    func bitacora(bitacoraUpdated bitacora: BitacoraEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension BitacoraDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.statusOfSelectedBitacora.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let statusOfSelectedBitacora = self.statusOfSelectedBitacora[section]
        return "#\(statusOfSelectedBitacora.bitactora?.id ?? 0) - [\(statusOfSelectedBitacora.created ?? Date.now)] \(section)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BitacoraStatusCell")
        
        var config = cell.defaultContentConfiguration()
        
        let statusOfSelectedBitacora = self.statusOfSelectedBitacora[indexPath.section]
        
        config.text = statusOfSelectedBitacora.label
        config.secondaryText = statusOfSelectedBitacora.status
        
        cell.contentConfiguration = config
        
        return cell
    }
    
}
 
