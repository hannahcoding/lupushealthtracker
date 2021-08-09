//
//  SymptomHistory.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 8/6/21.
//

import UIKit
import CoreData

class SymptomHistoryDetailView: SymptomHistoryTableView {
    
    @IBOutlet weak var sliderAction: UISlider!
    
    @IBOutlet weak var labelAction: UILabel!
    
    @IBOutlet weak var dateAction: UIDatePicker!
    
    @IBOutlet weak var addImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {labelAction.text = "\(sliderAction.value)"
    }
    
    @IBAction func saveSymptomHistory(_ sender: Any) {
        let symptomAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManaagedObjectContext = symptomAppDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Symptom History", in: context)
        let newSymptomHistory = SymptomHistory(entity: entity!, insertInto: context)
        newSymptomHistory.date = dateAction.date
        newSymptomHistory.severity = labelAction.attributedText
        newSymptomHistory.image = addImage.image
        do {
            try context.save()
            symptomHistoryList.append(newSymptomHistory)
        }
        catch
        {
            print("context save error")
        }
    }
    
    
}
