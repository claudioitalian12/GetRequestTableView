//
//  ViewController.swift
//  GetRequestTableView
//
//  Created by claudio Cavalli on 12/01/2019.
//  Copyright © 2019 claudio Cavalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var postData = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }


    func getRequest(){
        //create the url with NSURL
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try Post.init(data: data) as? Post {
                    self.postData = json
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row") as! TableViewCell
       
    cell.title.text = postData[indexPath.row].title
    cell.body.text  = postData[indexPath.row].body
    cell.id.text?.append(String(postData[indexPath.row].id!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

