//
//  ViewController.swift
//  progress
//
//  Created by Gale on 2/4/16.
//  Copyright © 2016 Gale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDataDelegate {

    @IBOutlet weak var dlImageView: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var connectionManager:NSURLConnection?
    var downloadedMutableData:NSMutableData?
    var urlResponse:NSURLResponse?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        progressBar.progress = 0.0
        self.downloadedMutableData = NSMutableData.init()
        let request = NSURLRequest(
            URL: NSURL(string: "http://www.devfright.com/wp-content/uploads/2014/05/iPhone4Wallpaper.jpg")!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        self.connectionManager = NSURLConnection(request: request, delegate:  self)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        print(response.expectedContentLength)
        self.urlResponse = response
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.downloadedMutableData?.appendData(data);
        self.progressBar.progress = Float(((100.0/Double((self.urlResponse?.expectedContentLength)!)) * Double((self.downloadedMutableData?.length)!))/100.0);
        print(progressBar.progress)
        
        if (self.progressBar.progress == 1) {
            self.progressBar.hidden = true
        } else {
            self.progressBar.hidden = false
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.dlImageView.image = UIImage(data: self.downloadedMutableData!)
        
    }

}

