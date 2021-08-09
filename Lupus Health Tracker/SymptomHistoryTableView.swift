//
//  SymptomHistoryTableView.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 8/6/21.
//

import UIKit
import CoreData

class SymptomHistoryTableView: MySymptomTableView {
    var firstHistoryLoad = true
    override func viewDidLoad() {
        if (firstHistoryLoad) {
            firstHistoryLoad = false
            let symptomAppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManaagedObjectContext = symptomAppDelegate.persistentContainer.viewContext
        }
    }
    
    var symptomHistoryList = [SymptomHistory]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let symptomHistoryCell = tableView.dequeueReusableCell(withIdentifier: "symptomhistorycell") as! symptomHistoryCell
        
        let thisSymptomHistory: SymptomHistory!
        thisSymptomHistory = symptomHistoryList[indexPath.row]
        
        symptomHistoryCell.dateAction.date = thisSymptomHistory.date
        symptomHistoryCell.labelAction.attributedText = thisSymptomHistory.severity
        symptomHistoryCell.addImage.image = thisSymptomHistory.image
        return symptomHistoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomHistoryList.count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}
