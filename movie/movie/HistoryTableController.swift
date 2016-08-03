//
//  HistoryTableController.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import UIKit

class HistoryTableController: UIViewController {
    
    // MARK: - Classes -
    let coreDataManager = CoreDataManager()
    
    // MARK: - Cell  -
    let historyReuseIdentifier = "HistoryCell"
    let historyXib = "HistoryTableCell"
    
    // MARK: - Variables  -
    var history:[History] = []
    var imdbString:String?
    
    // MARK: - UITableView  -
    @IBOutlet weak var histortTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.histortTableView.estimatedRowHeight = 142.0
        self.histortTableView.rowHeight = UITableViewAutomaticDimension
        
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: #selector(deleteAll))
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem], animated: true)
        self.title = "History"
        
        if let data = self.coreDataManager.getAllStoredProduct(){
            self.history = data
            histortTableView.reloadData()
        }
        
        histortTableView.registerNib(UINib(nibName: historyXib,bundle:nil), forCellReuseIdentifier: historyReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Functions -
    func deleteAll(){
        
        coreDataManager.deleteAllEntities("History")
        
        self.history = []
        self.histortTableView.reloadData()
        
    }
    
    // MARK: - Segueways -
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showMovie") {
            
            let svc = segue.destinationViewController as! MovieController;
            svc.imdbString = imdbString
            
        }
        
    }
    
}

extension HistoryTableController: UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return history.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = histortTableView.dequeueReusableCellWithIdentifier(historyReuseIdentifier, forIndexPath: indexPath) as! HistoryTableCell
        
        
        cell.movieName.text = history[indexPath.row].movieTitle
        cell.movieType.text = history[indexPath.row].movieType
        cell.movieYear.text = history[indexPath.row].movieYear
        if history[indexPath.row].moviePoster! != "N/A"{
            cell.moviePoster.kf_setImageWithURL(NSURL(string: history[indexPath.row].moviePoster!)!)
        }else{
            cell.moviePoster.image = UIImage(named: "noPoster")
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        imdbString = history[indexPath.row].movieImdbString
        self.performSegueWithIdentifier("showMovie", sender: self)
        
    }
    
    
    
}