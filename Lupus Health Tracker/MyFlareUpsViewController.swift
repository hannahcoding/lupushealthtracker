//
//  MyFlareUpsViewController.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/22/21.
//

import UIKit
import CoreData

class MyFlareUpsViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableView.self, forCellReuseIdentifier: "cell")
        return table
    }()
  
    private var models = [MyFlareUpsViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Flare Ups"
        view.addSubview(tableView)
        getAllFlareUps()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapFlareUpAdd))
    }
    @objc private func didTapFlareUpAdd() {
        let defaultAction = UIAlertAction(title: "Had Flare Up", style: .default) { (action) in }
        let cancelAction = UIAlertAction(title: "No Flare Up", style: .cancel) { (action) in }
        let alert = UIAlertController(title: "Did you have a flare up?" , message: "", preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        guard alert.actions.first != nil else {
            return
        }
        self.createFlareUp(flareups: Bool())
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (model.hadFlareUp); (model.date)
        return cell
    }

        // Do any additional setup after loading the view.
    
//coredata
    
    func getAllFlareUps() {
        do {
            let flareups = try context.fetch(FlareUps.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    
    func createFlareUp(flareups: Bool) {
        let newflareups = FlareUps(context: context)
        newflareups.hadFlareUp = Bool()
        newflareups.date = Date()
        do {
            try context.save()
            getAllFlareUps()
        }
        catch {
            
        }
    }
    
    func deleteFlareUp(flareups: FlareUps) {
        context.delete(flareups)
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func updateFlareUp(flareups: FlareUps, newFlareUp: Bool) {
        flareups.hadFlareUp = newFlareUp
        do {
            try context.save()
        }
        catch {
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
