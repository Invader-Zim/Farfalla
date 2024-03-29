//
//  ViewController.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/15/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var imageViewSearch: UIImageView?
    @IBOutlet weak var textFieldSearch: UITextField?
    @IBOutlet weak var buttonMediaType: UIButton?
    @IBOutlet weak var imageViewTitle: UIImageView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private var searchResults: SearchResults?
    private var appleSearchActive: AppleSearch?


    override func viewDidLoad() {
        super.viewDidLoad()

        searchStopped()
        
        self.tableView?.register(UINib(nibName:"SearchResultsPlaceholderCell", bundle: nil), forCellReuseIdentifier: "SearchResultsPlaceholderCell")
        self.tableView?.register(UINib(nibName:"SearchResultsCell", bundle: nil), forCellReuseIdentifier: "SearchResultsCell")
        self.tableView?.rowHeight = UITableViewAutomaticDimension;
        self.tableView?.estimatedRowHeight = 75.0;
        
        self.buttonMediaType?.setTitle("All", for: UIControlState.normal)
        
        imageViewTitle?.image = UIImage(named:"bee-white")?.withRenderingMode(.alwaysTemplate)
        imageViewTitle?.tintColor = self.view.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textFieldSearch?.text = SearchSettings.sharedInstance.searchText
        
        let mediaType = AppleSearchMediaTypes.sharedInstance.mediaTypes[SearchSettings.sharedInstance.mediaType!]
        buttonMediaType?.setTitle(mediaType, for: UIControlState.normal)
        imageViewSearch?.image = UIImage(named: "magnifying_glass")
        
        if ( searchResults?.searchTerms != SearchSettings.sharedInstance.searchText ||
            searchResults?.mediaType != SearchSettings.sharedInstance.mediaType) {
            startSearch()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SearchSettings.sharedInstance.searchText = textFieldSearch?.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDelegate

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if ( self.searchResults != nil ) {
            let vc = ResultDetailsTableViewController.init(nibName: "ResultDetailsTableViewController", bundle: nil)
            vc.resultItem = self.searchResults?.resultItems![indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
        return nil
    }

    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( section == 0 ) {
            if ( self.searchResults != nil ) {
                return self.searchResults!.resultItems!.count
            }
            else {
                return 1
            }
        }
        return 0
    }
        
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier
    // and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source
    // (accessory views, editing controls)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        if ( self.searchResults == nil ) {
            return self.tableView!.dequeueReusableCell(withIdentifier: "SearchResultsPlaceholderCell")!
        }

        let cell:SearchResultsCell = self.tableView!.dequeueReusableCell(withIdentifier: "SearchResultsCell") as! SearchResultsCell!
        let resultItem = self.searchResults?.resultItems![indexPath.row]
        var title = resultItem?.collectionName
        if ( title == nil ) {
            title = resultItem?.trackName
        }
        if ( title == nil ) {
            title = ""
        }
        cell.lblTitle?.text = title
        cell.lblSubtitle?.text = resultItem?.artistName
        cell.setImageUrl(urlString: resultItem?.artworkUrl60)
        return cell
    }
    
    // MARK: UITextFieldDelegate

    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        //Perform search
        if ( textField.text != SearchSettings.sharedInstance.searchText || self.searchResults == nil || ((self.searchResults?.resultItems!.count) != nil) ) {
            SearchSettings.sharedInstance.searchText = textField.text
            startSearch()
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Private Helpers
    
    @IBAction func onTextFieldTap(sender: UIButton) {
        self.textFieldSearch?.becomeFirstResponder()
    }
    
    func searchStarted() {
        self.activityIndicator?.startAnimating()
        self.imageViewSearch?.alpha = 0.2
    }
    
    func searchStopped() {
        self.activityIndicator?.stopAnimating()
        self.imageViewSearch?.alpha = 1.0
    }
    
    func startSearch() {
        if ( SearchSettings.sharedInstance.searchText == "" ) {
            self.searchResults = nil
            self.appleSearchActive = nil
            self.tableView?.reloadData()
            return
        }
        
        let curSearch = AppleSearch.init(withSearchTerm: SearchSettings.sharedInstance.searchText!, forMediaType: SearchSettings.sharedInstance.mediaType!)
        self.appleSearchActive = curSearch //We may issue another search before this one completes.
        searchStarted()
        curSearch.executeJob(withCompletion: { (results, error) in
            if ( error == nil && results != nil) {
                if ( curSearch == self.appleSearchActive ) {
                    self.searchStopped()
                    self.searchResults = results
                    self.appleSearchActive = nil
                    self.tableView?.reloadData()
                }
            }
        })
    }
}

