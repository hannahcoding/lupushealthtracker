//
//  MyJournalsEntry.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/22/21.
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var descTF: UITextView!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(selectedNote != nil)
        {
            titleTF.text = selectedNote?.title
            descTF.text = selectedNote?.description
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedNote == nil)
        {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let newNote = Note(entity: entity!, insertInto: context)
        newNote.id = noteList.count as NSNumber
        newNote.title = titleTF.text!
        newNote.description = descTF.text!
        do {
            try context.save()
            noteList.append(newNote)
            navigationController?.popViewController(animated: true)
            
        }
        catch {
            print("context save error")
        }
        }
        else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let note = result as! Note
                    if(note == selectedNote) {
                        note.title = titleTF.text!
                        note.description = descTF.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                        
                    }
                }
            }
            catch {
                print("Fetch failed")
            
        }
    }
}
    @IBAction func deletenote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let note = result as! Note
                if(note == selectedNote) {
                    note.isDeleted = Bool()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                    
                }
            }
        }
        catch {
            print("Fetch failed")
    }
}
}
