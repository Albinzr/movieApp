//
//  HomeController.swift
//  movie
//
//  Created by Albin on 01/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
  
    
    // MARK: - UILabel -
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 46.0/255.0, green: 14.0/255.0, blue: 74.0/255.0, alpha: 0.4)
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(history))
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem], animated: true)
        self.title = "Movie"
        
        
        
        
        // MARK: - searchTextField -
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.borderColor = Constants.color.salmonColor.CGColor
        
        // MARK: - searchBtn
        searchBtn.backgroundColor = Constants.color.salmonColor
        searchBtn.tintColor = Constants.color.white
        
        // Mark: - searchTitleLabel -
        searchTitleLabel.tintColor = Constants.color.grey
        searchTitleLabel.text = Constants.home.searchTitle
        
        // MARK: - descriptionLabel -
        descriptionLabel.tintColor = Constants.color.grey
        descriptionLabel.text = Constants.home.detail
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UIButton Actions -
    @IBAction func searchBtnAction(sender: AnyObject) {
        
        if searchTextField.text!.characters.count > 1{
            
            self.performSegueWithIdentifier("showSearch", sender: self)
            
        }
        
    }
    // MARK: -Functions -
    
    func history(){
        
        self.performSegueWithIdentifier("showHistory", sender: self)
        
    }
    
    
    // MARK: - Segueways -
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showSearch") {
 
            let svc = segue.destinationViewController as! SearchController;
            svc.movieName = searchTextField.text!
            
        }
        
    }
    
}

