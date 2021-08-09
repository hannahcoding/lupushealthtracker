//
//  journaltableview.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 8/1/21.
//

import UIKit
import CoreData
var noteList = [Note]()

class notetableView: UITableViewController {
   var firstLoad = true
    func nonDeletedNotes() -> [Note] {
        var noDeletedNoteList = [Note]()
        for note in noteList {
            if(note.isDeleted == nil)
            {
                noDeletedNoteList.append(note)
            }
        }
        return noDeletedNoteList
    }
    override func viewDidLoad() {
        if(firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let note = result as! Note
                    noteList.append(note)
                }
            }
            catch {
                print("Fetch failed")
            }
        }
    }
    
    override func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let notecell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! notecell
        
        let thisNote: Note!
        thisNote = nonDeletedNotes()[indexPath.row]
        
        notecell.titlelabel.text = thisNote.title
        notecell.desclabel.text = thisNote.description
        
        return notecell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedNotes().count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "EditNote", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EditNote")
        { let indexPath = tableView.indexPathForSelectedRow!
            let newJournal = segue.destination as? NoteDetailVC
            let selectedNote : Note!
            selectedNote = nonDeletedNotes()[indexPath.row]
            newJournal?.selectedNote = selectedNote
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

