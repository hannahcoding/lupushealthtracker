//
//  mymedicationsViewController.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 8/3/21.
//

import UIKit

class MyMedicationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    let mymedstableView: UITableView = {
        let medtable = UITableView()
        medtable.register(UITableViewCell.self, forCellReuseIdentifier: "medcell")
        return medtable
    }()

    private var medmodels = [MyMedications]()

    override func viewDidLoad() {
            super.viewDidLoad()
        title = "MyMedications"
        view.addSubview(mymedstableView)
        getAllMeds()
        mymedstableView.delegate = self
        mymedstableView.dataSource = self
        mymedstableView.frame = view.bounds

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapMedsAdd))
    }
    
    @objc private func didTapMedsAdd() {
        let medalert = UIAlertController(title: "New Medication",
                                         message: "Enter new medication",
                                         preferredStyle: .alert)
        medalert.addTextField(configurationHandler: nil)
        medalert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in guard let medfield = medalert.textFields?.first, let medtext = medfield.text, !medtext.isEmpty else {
            return
        }
        self?.createMeds(meds: String)
        }))
        present(medalert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medmodels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt medindexPath: IndexPath) -> UITableViewCell {
        let medmodel = medmodels[medindexPath.row]
        let medcell = mymedstableView.dequeueReusableCell(withIdentifier: "medcell", for: medindexPath)
        medcell.textLabel?.text = medmodel.medName
        return medcell
    }

    func mymedstableView(_ mymedstableView: UITableView, didSelectRowAt medindexPath: IndexPath) {
        mymedstableView.deselectRow(at: medindexPath, animated: true)
        let meds = medmodels[medindexPath.row]
        let medsheet = UIAlertController(title: "Edit",
                                         message: "nil",
                                         preferredStyle: .actionSheet)
                                         medsheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        medsheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: nil))
        medsheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            let medalert = UIAlertController(title: "Edit Medication", message: "Edit Your Medication", preferredStyle: .alert)
            medalert.addTextField(configurationHandler: nil)
            medalert.textFields?.first?.text = meds.medName
            medalert.addAction(UIAlertAction(title: "save", style: .cancel, handler: { [weak self] _ in guard let medfield = medalert.textFields?.first, let newMed = medfield.text, !newMed.isEmpty else {
                return
            }
            self?.updateMeds(meds: MyMedications, newMed: String)
            }))
            self.present(medalert, animated: true)
        }))
        medsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in self?.deleteMeds(meds: MyMedications)
    }))

    //coredata
    func getAllMeds() {
        do {
             medmodels = try context.fetch(MyMedications.fetchRequest())
            DispatchQueue.main.async {
                self.mymedstableView.reloadData()
            }
    }
        catch {

        }
    }

    func createMeds(meds: String) {
        let newMed = MyMedications(context: context)
        newMed.medName = meds
        do {
            try context.save()
        }
        catch {

        }
    }

    func deleteMeds(meds: MyMedications) {
        context.delete(meds)
        do {
            try context.save()
            getAllMeds()
        }
        catch {

        }
    }

    func updateMeds(meds: MyMedications, newMed: String) {
        meds.medName = newMed
        do {
            try context.save()
        }
        catch {

        }
    }
}
}


