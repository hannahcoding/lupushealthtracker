//
//  AddSymptom.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 8/5/21.
//

import UIKit
class MySymptomTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let MySymptomTableView: UITableView = {
        let mysymptomtable = UITableView()
        mysymptomtable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return mysymptomtable
    }()
    
    private var symptommodel = [MySymptoms]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MySymptoms"
        view.addSubview(MySymptomTableView)
        getAllSymptoms()
        MySymptomTableView.delegate = self
        MySymptomTableView.dataSource = self
        MySymptomTableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddSymptom))
    }
    
    @objc private func didTapAddSymptom() {
        let symptomalert = UIAlertController(title: "New Symptom", message: "Enter New Symptom", preferredStyle: .alert)
        symptomalert.addTextField(configurationHandler: nil)
        symptomalert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in guard let symptomfield = symptomalert.textFields?.first, let symptomtext = symptomfield.text, !symptomtext.isEmpty else {
            return
        }
        self?.createSymptoms(name: String)
        }))
        present(symptomalert, animated: true)
        
    }
    
    func MySymptomTableView(_ MySymptomTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomModels.count
    }
    
    func MySymptomTableView(_ MySymptomTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let symptommodel = symptomModels[indexPath.row]
        let symptomcell = MySymptomTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        symptomcell.textLabel?.text = symptommodel.name
        return symptomcell
    }
    
    func MySymptomTableView(_ MySymptomTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MySymptomTableView.deselectRow(at: indexPath, animated: true)
        let symptom = symptomModels[indexPath.row]
        
        let symptomsheet = UIAlertController(title: "Edit ", message: nil, preferredStyle: .actionSheet)
        symptomsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        symptomsheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let symptomalert = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
            symptomalert.addTextField(configurationHandler: nil)
            symptomalert.textFields?.first?.text = symptom.symptomName
            symptomalert.addAction(UIAlertAction(title: "save", style: .cancel, handler: { [weak self] _ in guard let symptomfield = symptomalert.textFields?.first, let newSymptom = symptomfield.text, !newSymptom.isEmpty else {
                return
            }
            self?.updateSymptoms(symptom: MySymptoms, newName: newSymptom)
            }))
            
            self.present(symptomalert, animated: true)
        }))
        symptomsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in self?.deleteSymptoms(symptom: MySymptoms)
        }))

        present(symptomsheet, animated: true)
    }
    
    //coredata
    func getAllSymptoms() {
        do { let symptomModels = try context.fetch(MySymptoms.fetchRequest())
            DispatchQueue.main.async {
                self.MySymptomTableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func createSymptoms(name: String) {
        let newSymptom = MySymptoms(context: context)
        newSymptom.symptomName = name
        
        do {
            try context.save()
            getAllSymptoms()
        }
        catch {
            
        }
    }
    
    func deleteSymptoms(symptom: MySymptoms) {
        context.delete(symptom)
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func updateSymptoms(symptom: MySymptoms, newName: String) {
        symptom.symptomName = newName
        do {
            try context.save()
        }
        catch {
            
        }
    }

}
