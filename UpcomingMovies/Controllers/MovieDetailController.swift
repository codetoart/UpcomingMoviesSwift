//
//  MovieDetailController.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 10/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import UIKit
import AsyncImageView

enum SectionType: Int {
    case title, release_DATE, rating, overview, count

    static let sectionTitles = [
        title: "TITLE",
        release_DATE: "RELEASE DATE",
        rating : "RATING",
        overview : "OVERVIEW"
    ]

    func getTitle() -> String {
        if let title = SectionType.sectionTitles[self] {
            return title
        } else {
            return "Unknown"
        }
    }

    static func sectionCount() -> Int {
        return SectionType.count.rawValue
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

        self.tableView.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "textCell")
        self.tableView.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: "ratingCell")
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()

        self.imageSliderView.setCurrentPageIndicatorTintColor(tintColor: UIColor.primaryColor())
        self.imageSliderView.tintColor = UIColor.primaryColor()
        self.imageSliderView.font = UIFont.regularFont(15)
        self.imageSliderView.dataSource = self
//        self.imageSliderView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.sectionCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = SectionType(rawValue: section)
        return sectionType!.getTitle()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)
        var cell: UITableViewCell?
        switch sectionType! {
            case .title:
                let textCell = self.tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextCell
                textCell.configure(self.movieDetailViewModel?.getTitle(), font: UIFont.mediumFont(17))
                cell = textCell
            case .release_DATE:
                let textCell = self.tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextCell
                textCell.configure(self.movieDetailViewModel?.formattedReleaseDate())
                cell = textCell
            case .rating:
                let ratingCell = self.tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! RatingCell
                ratingCell.configure(self.movieDetailViewModel?.getRating())
                cell = ratingCell
            case .overview:
                let textCell = self.tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextCell
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

    func imageURLFor(_ index: Int) -> URL? {
        return self.movieDetailViewModel?.images?[index] as URL?
    }
}



import UIKit
import SnapKit

class ImageSliderFullScreenController: UIViewController {

    var images: Array<URL>?
    var tintColor: UIColor = UIColor.blue
    var font: UIFont = UIFont.systemFont(ofSize: 15)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        let imageSliderView = ImageSliderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        imageSliderView.allowFullscreenOnTap = false
        imageSliderView.dataSource = self
        self.view.addSubview(imageSliderView)
        imageSliderView.snp_remakeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        imageSliderView.reloadData()

        let closeBtn = UIButton()
        closeBtn.setTitle(NSLocalizedString("Close", comment: ""), for: .normal)
        closeBtn.backgroundColor = tintColor
        closeBtn.titleLabel?.font = self.font
        self.view.addSubview(closeBtn)
        closeBtn.snp_remakeConstraints { (make) in
            make.leading.equalTo(self.view.snp_leading).offset(8)
            make.top.equalTo(self.view.snp_top).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(60)
        }
        self.view.layoutIfNeeded()
        closeBtn.layer.cornerRadius = 5
        closeBtn.clipsToBounds = true
        closeBtn.layer.borderWidth = 1.0
        closeBtn.layer.borderColor = UIColor.white.cgColor
        closeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func prefersStatusBarHidden() -> Bool {
//        return true
//    }

    @objc func closeBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension ImageSliderFullScreenController: ImageSliderViewDataSource {
    func numberOfImages() -> Int? {
        return self.images?.count
    }

    func imageURLFor(_ index: Int) -> URL? {
        return self.images?[index]
    }
}


public protocol ImageSliderViewDelegate: class {
    func didTapImage(_ index: Int)
}

public protocol ImageSliderViewDataSource: class {
    func numberOfImages() -> Int?
    func imageURLFor(_ index: Int) -> URL?
}

open class ImageSliderView: UIView {

    open var viewMode: UIView.ContentMode = .scaleAspectFit
    open var allowFullscreenOnTap = true
    open var font: UIFont = UIFont.systemFont(ofSize: 15)
    open weak var dataSource: ImageSliderViewDataSource?
    open weak var delegate: ImageSliderViewDelegate?

    fileprivate var scrollView: UIScrollView?
    fileprivate var pageControl: UIPageControl?
    fileprivate var imageURLArray = Array<URL>()

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    public func setPageIndicatorTintColor(tintColor: UIColor) {
        self.pageControl?.pageIndicatorTintColor = tintColor
    }

    public func setCurrentPageIndicatorTintColor(tintColor: UIColor) {
        self.pageControl?.currentPageIndicatorTintColor = tintColor
    }

    public func reloadData() {
        if let numImages = self.dataSource?.numberOfImages(), numImages > 0 {
            // remove all subviews
            self.imageURLArray = (0...numImages-1).filter({
                self.dataSource?.imageURLFor($0) != nil
            }).map({
                self.dataSource!.imageURLFor($0)!
            })
            self.layoutImages()
        }
    }



    private func setup() {
        self.backgroundColor = UIColor.black
        createScrollViewIfRequired()
        createPageControlIffRequired()
        reloadData()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(ImageSliderView.orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    private func createScrollViewIfRequired() {
        if self.scrollView == nil {
            self.scrollView = UIScrollView()
            self.scrollView?.showsHorizontalScrollIndicator = false
            self.scrollView?.isPagingEnabled = true
            self.scrollView?.delegate = self
            self.addSubview(self.scrollView!)
            self.scrollView!.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(self)
            }
        }
    }

    private func createPageControlIffRequired() {
        if self.pageControl == nil {
            self.pageControl = UIPageControl()
            self.pageControl?.hidesForSinglePage = true
            self.pageControl?.currentPageIndicatorTintColor = UIColor.white
            self.pageControl?.tintColor = UIColor.black
            self.addSubview(self.pageControl!)
            self.pageControl?.snp_makeConstraints({ (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.bottom.equalTo(self.snp_bottom).offset(-8)
            })
        }
    }

    private func layoutImages() {
        for sv in self.scrollView!.subviews {
            sv.removeFromSuperview()
        }
        let width = self.bounds.width
        let height = self.bounds.height
        var index = 0

        for imageURL in self.imageURLArray {
            let imageView = AsyncImageView(frame: CGRect(x: width*CGFloat(index), y: 0, width: width, height: height))
            imageView.contentMode = viewMode
            imageView.backgroundColor = UIColor.black
            imageView.showActivityIndicator = true
            imageView.activityIndicatorColor = UIColor.white
            imageView.activityIndicatorStyle = .white
            imageView.imageURL = imageURL as URL
            imageView.isUserInteractionEnabled = allowFullscreenOnTap
            if allowFullscreenOnTap {
                let tgr = UITapGestureRecognizer(
                    target: self,
                    action: #selector(ImageSliderView.imageTapped)
                )
                imageView.addGestureRecognizer(tgr)
            }
            self.scrollView?.addSubview(imageView)
            index += 1
        }

        self.scrollView?.contentSize = CGSize(width: width*CGFloat(self.imageURLArray.count), height: height)
        self.scrollView?.contentOffset = .zero
        self.bringSubviewToFront(self.pageControl!)
        self.pageControl?.numberOfPages = self.imageURLArray.count
    }

    @objc private func orientationChanged() {
        if let numImages = self.dataSource?.numberOfImages(), numImages > 0 {
            let imageViews = self.scrollView?.subviews.map{$0 as? AsyncImageView}
            let width = self.bounds.width
            let height = self.bounds.height
            for index in 0...numImages-1 {
                if let imageView = imageViews?[index] {
                    imageView.frame = CGRect(x: width*CGFloat(index),y: 0,width: width,height: height)
                }
            }

            self.scrollView?.contentSize = CGSize(width: CGFloat(numImages)*width,height: height)
            self.scrollView?.contentOffset = CGPoint(x: CGFloat(self.pageControl!.currentPage)*width,y: 0)
        }
    }

    @objc private func imageTapped(sender: AsyncImageView) {
        if let parentVC = getParentViewController() {
            let fullScreenController = ImageSliderFullScreenController()
            fullScreenController.images = self.imageURLArray
            fullScreenController.font = self.font
            fullScreenController.tintColor = self.tintColor
            parentVC.present(fullScreenController, animated: true, completion: {

            })
        }
    }

    private func getParentViewController() -> UIViewController? {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }

        return topVC
    }

}

extension ImageSliderView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.bounds.width
        self.pageControl?.currentPage = Int(scrollView.contentOffset.x/width)
    }
}
