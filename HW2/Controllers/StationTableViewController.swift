//
//  StationTableViewController.swift
//  HW2
//
//  Created by Майя Герасимова on 02.12.2020.
//

import UIKit

class StationTableViewController: UITableViewController {

    var stations = [Station]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure()
        // Do any additional setup after loading the view.
    }
//    private func configure() {
//        datlabel.text = "Привет, "+text+"!"
//        //вапролдж
//    }
}


extension StationTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let station = stations[indexPath.row]
        
        cell.textLabel?.text = station.name
        
        return cell
    }
    

}
