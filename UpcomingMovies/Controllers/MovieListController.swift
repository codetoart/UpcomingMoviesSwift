//
//  MovieListController.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 10/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import UIKit

class MovieListController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    private var movieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Movies", comment: "")
        
        self.movieListViewModel.vc = self
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.activityIndicatorView.isAnimating() {
            self.activityIndicatorView.startAnimating()
        }
        
        var cs = ConfigurationService()
        cs.delegate = self
        cs.fetchConfig()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.separatorInset = UIEdgeInsetsZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViews() {
        if self.activityIndicatorView.isAnimating() {
            self.activityIndicatorView.stopAnimating()
        }
        self.tableView.reloadData()
    }
    
//    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showMovieDetail" {
//            if let mdc = segue.destinationViewController as? MovieDetailController, selectedMovie = self.movieListViewModel.getSelectedMovie() {
//                mdc.movieDetailViewModel = MovieDetailViewModel(selectedMovie)
//            }
//        }
//    }
}

extension MovieListController: ConfigurationServiceDelegate {
    func didReceiveConfig(config: Config) {
        AppHelper.saveConfig(config)
        self.movieListViewModel.getMovies()
    }
}

extension MovieListController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListViewModel.movieCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mc = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        let movieCellViewModel = self.movieListViewModel.getMovieCellViewModel(indexPath.row)
        mc.setup(movieCellViewModel)
        
        return mc
    }
}

extension MovieListController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.movieListViewModel.selectMovieAtIndex(indexPath.row)
        self.performSegueWithIdentifier("showMovieDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
}

extension MovieListController: UINavigationControllerDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovieDetail" {
            if let mdc = segue.destinationViewController as? MovieDetailController, selectedMovie = self.movieListViewModel.getSelectedMovie() {
                mdc.movieDetailViewModel = MovieDetailViewModel(selectedMovie, movieDetailController: mdc)
            }
        }
    }
}
