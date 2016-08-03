//
//  SearchController.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import UIKit
import SwiftSpinner


class SearchController: UIViewController {
    
    // MARK: - Cell details -
    let searchReuseIdentifier = "SearchCell"
    let searchXib = "SearchTableCell"
    
    // MARK: - Classes -
    let getSearchResult = SearchEngine()
    
    
    // MARK: - UIView -
    @IBOutlet weak var notFoundView: UIView!
    
    // MARK: - UILabel -
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - UIButton -
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    // MARK: - UITableView -
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Variable -
    var imdbString:String?
    var movieName:String?
    var search = [SearchModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Result"
        self.searchTableView.estimatedRowHeight = 142.0
        self.searchTableView.rowHeight = UITableViewAutomaticDimension
        
        searchTableView.registerNib(UINib(nibName: searchXib,bundle:nil), forCellReuseIdentifier: searchReuseIdentifier)
        
        tryAgainBtn.backgroundColor = Constants.color.salmonColor
        tryAgainBtn.tintColor = Constants.color.white
        tryAgainBtn.hidden = true
        notFoundView.hidden = true
        errorMessageLabel.hidden = true
        SwiftSpinner.show("loading")
        let urlString = movieName!.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        getSearchResult.getSearchResult(urlString) { (data, status) in
            dispatch_async(dispatch_get_main_queue(), {
                if status{
                    self.search = data as! [SearchModel]
                    
                    if self.search[0].response == "True"{
                        self.searchTableView.reloadData()
                    }else{
                        self.tryAgainBtn.hidden = false
                        self.notFoundView.hidden = false
                        self.errorMessageLabel.hidden = false
                        self.errorMessageLabel.text = Constants.error.notFound
                    }
                    SwiftSpinner.hide()
                    
                }else{
                    //hide
                    self.tryAgainBtn.hidden = false
                    self.notFoundView.hidden = false
                    self.errorMessageLabel.hidden = false
                    self.errorMessageLabel.text = Constants.error.notFound
                    SwiftSpinner.hide()
                }
            })
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIButton Action -
    
    @IBAction func tryAgainBtnAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    // MARK: - Segueways -
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showMovie") {
            let svc = segue.destinationViewController as! MovieController;
            svc.imdbString = imdbString!
            
        }
        
    }
    
    
}


extension SearchController: UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return search.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCellWithIdentifier(searchReuseIdentifier, forIndexPath: indexPath) as! SearchTableCell
        
        cell.movieName.text = search[indexPath.row].movieTitle!
        cell.movieType.text = search[indexPath.row].movieType!
        cell.movieYear.text = search[indexPath.row].movieType!
        
        if search[indexPath.row].moviePoster! != "N/A"{
            cell.moviePoster.kf_setImageWithURL(NSURL(string: search[indexPath.row].moviePoster!)!)
        }else{
            cell.moviePoster.image = UIImage(named: "noPoster")
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        imdbString = search[indexPath.row].movieImdbString!
        self.performSegueWithIdentifier("showMovie", sender: self)
        
    }
    
    
    
}