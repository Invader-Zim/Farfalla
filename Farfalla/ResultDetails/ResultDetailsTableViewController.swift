//
//  ResultDetailsTableViewController.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/17/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class ResultDetailsTableViewController: UITableViewController {
    
    @IBOutlet var artworkCell: UITableViewCell?
    @IBOutlet var imageViewArtwork: UIImageView?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?

    var resultItem: ResultItem?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        activityStopped()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.tableView?.register(UINib(nibName:"ResultDetailsPropertyCell", bundle: nil), forCellReuseIdentifier: "ResultDetailsPropertyCell")
        self.tableView?.rowHeight = UITableViewAutomaticDimension;
        self.tableView?.estimatedRowHeight = 75.0;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityStopped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( 0 == section ) {
            return 1
        }
        else if( 1 == section ) {
            return AppleResultProperies.sharedInstance.propertiesSorted.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ( indexPath.section == 0 ) {
            updateImageView()
            return artworkCell!
        }
        
        let cell:ResultDetailsPropertyCell = tableView.dequeueReusableCell(withIdentifier: "ResultDetailsPropertyCell", for: indexPath) as! ResultDetailsPropertyCell
        cell.lblProperty?.text = AppleResultProperies.sharedInstance.resultProperties[AppleResultProperies.sharedInstance.propertiesSorted[indexPath.row]];
        let val = resultItem?.resultDict![AppleResultProperies.sharedInstance.propertiesSorted[indexPath.row]] as! NSObject?
        if ( val == nil ) {
            cell.lblPropertyValye?.text = ""
        }
        else if ( val?.isKind(of: NSNumber.self) )! {
            let num = val as! NSNumber
            if ( num.floatValue >= 0.0 ) {
                cell.lblPropertyValye?.text = String.init(format: "$%0.2f", num.floatValue)
            }
            else {
                cell.lblPropertyValye?.text = ""                
            }
        }
        else {
            cell.lblPropertyValye?.text = val as? String
        }
        return cell
    }

    // MARK: Event Notifications
    
    @objc func imageCacheChanged(notification: NSNotification){
        let strUrl = notification.userInfo!["urlString"] as! String
        if ( strUrl == resultItem?.artworkUrl100 ) {
            DispatchQueue.main.async {
                self.updateImageView()
            }
        }
    }

    // MARK: Private Helpers
    
    func activityStarted() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.imageCacheChanged),
            name: .imageCacheChanged,
            object: nil)
        
        self.activityIndicator?.startAnimating()
        imageViewArtwork?.alpha = 0.2
    }
    
    func activityStopped() {
        NotificationCenter.default.removeObserver(self)
        
        self.activityIndicator?.stopAnimating()
        imageViewArtwork?.alpha = 1.0
    }
    
    func updateImageView() {
        
        if ( nil == resultItem?.artworkUrl100 ) {
            imageViewArtwork?.image = UIImage(named: "bee-white")
            activityStopped()
            return
        }
        
        let image100 = ImageCache.sharedInstance.imageFromUrl(url: URL.init(string: (resultItem?.artworkUrl100!)!)!) as? UIImage
        if ( image100 == nil ) {
            //Fallback to artworkUrl60 while we
            let image60 = ImageCache.sharedInstance.imageFromUrl(url: URL.init(string: (resultItem?.artworkUrl60!)!)!) as? UIImage
            if ( image60 == nil ) {
                imageViewArtwork?.image = UIImage(named: "bee-white")
            }
            else {
                imageViewArtwork?.image = image60
            }
            activityStarted()
        }
        else {
            imageViewArtwork?.image = image100
            activityStopped()
        }
        
    }
}
