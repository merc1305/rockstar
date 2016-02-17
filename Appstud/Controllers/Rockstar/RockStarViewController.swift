//
//  RockStarViewController.swift
//  Appstud
//
//  Created by Toan on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

class RockStarViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Create search controller from iOS 8
    var searchController: UISearchController!
    // Create UIRefreshControl
    var refreshControl:UIRefreshControl!
    // Create a flag to cache search or not
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup Table
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        // Create refresh
        self.refreshControl = UIRefreshControl()
        // Set action for UIRefreshControl
        refreshControl.addTarget(self, action: Selector("getDataFromServer"), forControlEvents: .ValueChanged)
        // Set title by NSAttributedString
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        // Set background
        self.refreshControl.backgroundColor = UIColor.clearColor()
        self.tableView.addSubview(self.refreshControl)
        
        // Configure Search Bar
        self.configureSearchController()
        
        let contact : RSContact = RSContact()
        let testImage : UIImageView = UIImageView(image: nil)
        testImage.sd_setImageWithURL(NSURL(string: contact.profileImage()), placeholderImage: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    // MARK: - UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return 1
        }
        else {
            return 5
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : RockstarTableCell = tableView.dequeueReusableCellWithIdentifier(RockstarTableCell.cellReuseIdentifier()) as! RockstarTableCell
        
        // check user is searching?
        if shouldShowSearchResults {

        }
        else {

        }
        
        // handle user tapped on check box
        cell.didTapCheckBoxClosure = { [unowned self](sender :UIButton) -> Void in
            
        }


        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(_tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if shouldShowSearchResults {
            
        }else{
            
        }
    }
    
    /*
    // MARK: - UIRefreshControl Method
    */
    func getDataFromServer(){
        
    }

    /*
    // MARK: - Search Bar Contoller Method & Delegate
    */

    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a rockstar..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text?.lowercaseString
        
        if searchString?.isEmpty == false{
            
        }else{

        }
        
        // Reload the tableview.
        self.tableView.reloadData()
    }

}
