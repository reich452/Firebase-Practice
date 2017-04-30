//
//  ResponseTableViewController.swift
//  HelloFirebaseTutorial
//
//  Created by Nick Reichard on 4/30/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class ResponseTableViewController: UITableViewController {
    
    // First call the data
    var surveys: [Survey] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SurveyController.fetchResponses { (surveys) in
            self.surveys = surveys
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return surveys.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "surveyCell", for: indexPath)
        
        let survey = surveys[indexPath.row]
        cell.textLabel?.text = survey.name
        cell.detailTextLabel?.text = survey.favoriteEmoji
        
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let survey = surveys[indexPath.row]
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
