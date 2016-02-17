//
//  BookmarksViewController.swift
//  Appstud
//
//  Created by Toan on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Create array to save data
    var bookMarkArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup Table
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // get bookmark list
        if let array = BookmarkHelper.getBookmarkList(){
            self.bookMarkArray = NSMutableArray(array: array)
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: -
    // MARK: - UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookMarkArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : BookmarkTableCell = tableView.dequeueReusableCellWithIdentifier(BookmarkTableCell.cellReuseIdentifier()) as! BookmarkTableCell
        
        let contact = self.bookMarkArray[indexPath.row] as! RSContact
        
        // display data
        cell.reloadDataFromRSContact(contact)
        
        // handle tap delete
        cell.didTapDeleteClosure = { [unowned self](sender :UIButton) -> Void in
            self.bookMarkArray.removeObjectAtIndex(indexPath.row)
            BookmarkHelper.removeContact(contact)
            self.tableView.reloadData()
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

}
