//
//  MovieController.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftSpinner

class MovieController: UIViewController {
    
    // MARK: - Classes -
    
    let movieData = MovieEngine()
    let movieUtility = UIUtility()
    
    // MARK: - UIImage -
    
    @IBOutlet weak var poster: UIImageView!
    
    // MARK: - UILabel -
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var imdbVoteLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: - Constrain -
    
    @IBOutlet weak var constrainDetail: NSLayoutConstraint!
    
    // MARK: - UIButton -
    
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    // MARK: - UIView -
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var notFoundView: UIView!
    
    // MARK: - Variables -
    
    let kMaxDetailViewHeight:CGFloat = 500
    let kMinDetailViewHeight:CGFloat = 100
    
    var imdbString:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tryAgainBtn.backgroundColor = Constants.color.salmonColor
        tryAgainBtn.tintColor = Constants.color.white
        tryAgainBtn.hidden = true
        notFoundView.hidden = true
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        constrainDetail.constant = kMinDetailViewHeight
        self.navigationItem.title = "Detail View"
        SwiftSpinner.show("loading")
        movieData.getMovieDetails(imdbString!)  { (data, status) in
            dispatch_async(dispatch_get_main_queue(), {
                
                if status{
                    
                    let movieDetails = data as! MovieModel
                    
                    if movieDetails.response == "True"{
                        if movieDetails.poster! != "N/A"{
                            self.poster.kf_setImageWithURL(NSURL(string: movieDetails.poster!)!)
                        }else{
                            self.poster.image = UIImage(named: "noPoster")
                        }
                        
                        
                        self.movieTitle.text = movieDetails.title!
                        self.yearLabel.text = movieDetails.year!
                        self.ratingLabel.text = movieDetails.rated!
                        self.releasedLabel.text = movieDetails.released!
                        self.timeLabel.text = movieDetails.runTime!
                        self.genreLabel.text = movieDetails.genre!
                        self.directorLabel.text = movieDetails.director!
                        self.writerLabel.text = movieDetails.writer!
                        self.languageLabel.text = movieDetails.language!
                        self.plotLabel.text = movieDetails.plot!
                        self.awardsLabel.text = movieDetails.awards!
                        self.imdbLabel.text = movieDetails.imdbRating
                        self.imdbVoteLabel.text = movieDetails.imdbVotes!
                        
                    }else{
                        print("no related movie")
                        
                        self.notFoundView.hidden = false
                        self.tryAgainBtn.hidden = false
                        self.errorLabel.text = Constants.error.notFound
                    }
                    SwiftSpinner.hide()
                    
                }else{
                    print("error:",data)
                    self.notFoundView.hidden = false
                    self.tryAgainBtn.hidden = false
                    self.errorLabel.text = Constants.error.oopsError
                    SwiftSpinner.hide()
                }
                
            })
        }
        
    }
    
    // MARK: - UIBUtton Actions  -
    @IBAction func showMoreBtnAction(sender: AnyObject) {
        
        if showMoreBtn.selected{
            
            constrainDetail.constant = kMinDetailViewHeight
            showMoreBtn.selected = false
            
            
        }else{
            let plotheight = plotLabel.frame.height
            constrainDetail.constant = kMaxDetailViewHeight + plotheight
            showMoreBtn.selected = true
            
        }
        Animation()
        
        
    }
    
    @IBAction func tryAgainBtnAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    // MARK: - Functions for animation -
    
    func Animation(){
        UIView.animateWithDuration(1, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    
}
