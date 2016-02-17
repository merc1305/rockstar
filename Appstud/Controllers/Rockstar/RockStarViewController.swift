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
    // Create array to save data
    var rockStarArray = NSMutableArray()
    var rockStarSearchArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup Table
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        // Create refresh
        self.refreshControl = UIRefreshControl()
        // Set action for UIRefreshControl
        self.refreshControl.addTarget(self, action: Selector("getDataFromServer"), forControlEvents: .ValueChanged)
        // Set title by NSAttributedString
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        // Add subview
        self.tableView.addSubview(self.refreshControl)
        
        // Configure Search Bar
        self.configureSearchController()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get Data From Server
        self.getDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    // MARK: - UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return self.rockStarSearchArray.count
        }
        else {
            return self.rockStarArray.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : RockstarTableCell = tableView.dequeueReusableCellWithIdentifier(RockstarTableCell.cellReuseIdentifier()) as! RockstarTableCell
        
        let contact: RSContact?
        // check user is searching?
        if shouldShowSearchResults {
            contact = self.rockStarSearchArray[indexPath.row] as? RSContact
        }
        else {
            contact = self.rockStarArray[indexPath.row] as? RSContact
        }
        
        // display data
        cell.reloadDataFromRSContact(contact!)
        
        // handle user tapped on check box
        cell.didTapCheckBoxClosure = { [unowned self](sender :UIButton) -> Void in
            if contact?.isBookmark == true{
                self.setBookMarkRockStar(contact!, selected: false)
            }else{
                self.setBookMarkRockStar(contact!, selected: true)
            }
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
    // MARK: - Public Method
    */
    
    func getDataFromServer(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            ServiceManager.requestToGetContacts({ (rockStar) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.rockStarArray = NSMutableArray(array: rockStar!)
                    // check rockstar is bookmark or not
                    self.rockStarArray.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
                        if let contact = obj as? RSContact{
                            contact.isBookmark = BookmarkHelper.isContactInBookmarkList(contact)
                        }
                    })
                    // reload data
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                })
                }) { (error) -> () in
                    print(error)
            }
        }
    }
    
    func setBookMarkRockStar(contact: RSContact, selected: Bool){
        if selected{
            BookmarkHelper.addContact(contact)
            contact.isBookmark = true
            
        }else{
            BookmarkHelper.removeContact(contact)
            contact.isBookmark = false
        }
        
        // check if user is searching
        if shouldShowSearchResults{
            self.rockStarArray.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
                if let contactArray = obj as? RSContact{
                    if contact.firstName == contactArray.firstName &&
                        contact.lastName == contactArray.lastName{
                        
                        self.rockStarArray.replaceObjectAtIndex(index, withObject: contact)
                        let shouldStop: ObjCBool = true
                        stop.initialize(shouldStop)
                    }
                }
            })
        }
        
        self.tableView.reloadData()
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
            self.rockStarSearchArray.removeAllObjects()
            
            for person in self.rockStarArray{
                // name
                let contactName = NSString(format: "%@ %@",(person as! RSContact).firstName!,(person as! RSContact).lastName!)
                if (contactName.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound{
                    self.rockStarSearchArray.addObject(person)
                }
            }
            
        }else{
            self.rockStarSearchArray.removeAllObjects()
        }
        
        // Reload the tableview.
        self.tableView.reloadData()
    }

}
