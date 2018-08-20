//
//  TableViewController.swift
//  JSONParse
//
//  Created by GAURAV on 15/07/18.
//  Copyright © 2018 Jahnavi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class TableViewController: UITableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var tableData = [Table]()
    var searchText: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callJSONURL()
    }
    
    func callJSONURL() {
        searchText = searchText?.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        self.getDataFromURL(url: searchText?.isEmpty == true ? "" : "http://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(searchText ?? "")%20Ei&gpslimit=10")
    }
    
    func getDataFromURL(url: String){
        if url.isEmpty { return }
        Alamofire.request(url).responseJSON { response in
            let result = JSON(response.result.value ?? "")
            let query = result["query"]["pages"].array
            guard query != nil else { return }
            for values in query! {
                let thumbnail = values["thumbnail"]["source"].stringValue
                let terms = values["terms"]["description"].rawValue
                let title = values["title"].stringValue
                self.tableData.append(Table(imageURL: thumbnail,textForLabel: String(describing: terms),title: title))}
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
        tableData = []
        self.callJSONURL()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellIdentifier", for: indexPath) as! TableViewCell
        let table: Table
        table = tableData[indexPath.row]
        cell.textFieldCell.text = table.textForLabel
        Alamofire.request(table.imageURL ?? "").responseImage { response in
            if let image = response.result.value {
                cell.imageViewCell.image = image
            } else {
                cell.imageViewCell.image = UIImage(named:"default")
            }
        }
        cell.textFieldCell.text = table.textForLabel
        cell.titleLabel.text = table.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table: Table
        table = tableData[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.valueForURL = table.title
        navigationController!.pushViewController(viewController, animated: true)
    }
    
}
