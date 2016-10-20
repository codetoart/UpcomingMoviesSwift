//
//  MovieDetailController.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 10/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import UIKit
import ImageSliderView

enum SectionType: Int {
    case TITLE, RELEASE_DATE, RATING, OVERVIEW, COUNT
    
    static let sectionTitles = [
        TITLE: "TITLE",
        RELEASE_DATE: "RELEASE DATE",
        RATING : "RATING",
        OVERVIEW : "OVERVIEW"
    ]
    
    func getTitle() -> String {
        if let title = SectionType.sectionTitles[self] {
            return title
        } else {
            return "Unknown"
        }
    }
    
    static func sectionCount() -> Int {
        return SectionType.COUNT.rawValue
    }
    
}

class MovieDetailController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageSliderView: ImageSliderView!
    
    var movieDetailViewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = self.movieDetailViewModel?.getTitle()
        
        self.tableView.registerNib(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "textCell")
        self.tableView.registerNib(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: "ratingCell")
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        
        self.imageSliderView.setCurrentPageIndicatorTintColor(UIColor.primaryColor())
        self.imageSliderView.tintColor = UIColor.primaryColor()
        self.imageSliderView.font = UIFont.regularFont(15)
        self.imageSliderView.dataSource = self
//        self.imageSliderView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movieDetailViewModel?.getMovieImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayImages() {
        self.imageSliderView.reloadData()
    }
}

extension MovieDetailController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionType.sectionCount()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = SectionType(rawValue: section)
        return sectionType!.getTitle()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)
        var cell: UITableViewCell?
        switch sectionType! {
            case .TITLE:
                let textCell = self.tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! TextCell
                textCell.configure(self.movieDetailViewModel?.getTitle(), font: UIFont.mediumFont(17))
                cell = textCell
            case .RELEASE_DATE:
                let textCell = self.tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! TextCell
                textCell.configure(self.movieDetailViewModel?.formattedReleaseDate())
                cell = textCell
            case .RATING:
                let ratingCell = self.tableView.dequeueReusableCellWithIdentifier("ratingCell", forIndexPath: indexPath) as! RatingCell
                ratingCell.configure(self.movieDetailViewModel?.getRating())
                cell = ratingCell
            case .OVERVIEW:
                let textCell = self.tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! TextCell
                textCell.configure(self.movieDetailViewModel?.getOverview())
                cell = textCell
            default:
                cell = self.movieDetailViewModel!.getDefaultCell()
        }
        
        return cell!
    }
    
}

extension MovieDetailController: ImageSliderViewDataSource {
    func numberOfImages() -> Int? {
        return self.movieDetailViewModel?.images?.count
    }
    
    func imageURLFor(index: Int) -> NSURL? {
        return self.movieDetailViewModel?.images?[index]
    }
}
