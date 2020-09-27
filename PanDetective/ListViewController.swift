//
//  ListViewController.swift
//  PanDetective
//
//  Created by Keiko Makino on 2020/09/26.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var likedName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = likedName[indexPath.row]
        return cell
    }

}
