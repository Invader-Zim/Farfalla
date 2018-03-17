//
//  MediaTypeViewController.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/17/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class MediaTypeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UITableViewDataSource
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( section == 0 )
        {
            return AppleSearchMediaTypes.sharedInstance.mediaTypesSorted.count;
        }
        return 0
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier
    // and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source
    // (accessory views, editing controls)
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell: UITableViewCell = UITableViewCell.init()
        cell.backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
        cell.textLabel?.textColor = UIColor.init(white: 1.0, alpha: 0.9)
        cell.textLabel?.text = AppleSearchMediaTypes.sharedInstance.mediaTypes[AppleSearchMediaTypes.sharedInstance.mediaTypesSorted[indexPath.row]];
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SearchSettings.sharedInstance.mediaType = AppleSearchMediaTypes.sharedInstance.mediaTypesSorted[indexPath.row];
        self.navigationController?.popViewController(animated: true)
    }
}
