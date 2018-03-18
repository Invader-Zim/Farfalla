//
//  SearchResultsCell.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/17/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {
    
    @IBOutlet weak var imageViewItem: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblSubtitle: UILabel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?

    private var urlForImage: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        activityStopped()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        activityStopped()
        lblTitle?.text = ""
        lblSubtitle?.text = ""
        urlForImage = nil
        setImageUrl(urlString: nil)
    }
    
    // MARK: Publc Accessor
    
    func setImageUrl(urlString: String?) {
        urlForImage = urlString
        
        if ( nil == urlForImage ) {
            imageViewItem?.image = UIImage(named: "bee-white")
            activityStopped()
            return
        }
        
        let image = ImageCache.sharedInstance.imageFromUrl(url: URL.init(string: urlForImage!)!) as? UIImage
        if ( image == nil ) {
            imageViewItem?.image = UIImage(named: "bee-white")
            activityStarted()
        }
        else {
            imageViewItem?.image = image
            activityStopped()
        }
    }
    
    // MARK: Event Notifications
    
    @objc func imageCacheChanged(notification: NSNotification){
        let strUrl = notification.userInfo!["urlString"] as! String
        if ( strUrl == urlForImage ) {
            DispatchQueue.main.async {
                self.setImageUrl(urlString: strUrl)
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
        self.imageViewItem?.alpha = 0.2
    }
    
    func activityStopped() {
        NotificationCenter.default.removeObserver(self)
        
        self.activityIndicator?.stopAnimating()
        self.imageViewItem?.alpha = 1.0
    }
}
