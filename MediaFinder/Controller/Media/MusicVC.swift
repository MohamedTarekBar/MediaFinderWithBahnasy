//
//  ViewController.swift
//  ToDoList
//
//  Created by MohamedTarek on 05/01/2021.
//

import UIKit
import SDWebImage

class MusicVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cellReuseIdentifier = "tableViewCell"
    let secondCellIdentfier = "secondCell"
    let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
    var media:[Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
    }

}


extension MusicVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        if media.count == 0 {
            cell.textLabel?.text = ""
        } else {
            cell.media = media[indexPath.row]
            cell.labelView.text = media[indexPath.row].trackName
            cell.imageView?.downladImage(urlString: media[indexPath.row].artworkUrl100)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PlayerVC") as! PlayerVC
        playerVC.media = media[indexPath.row]
        self.navigationController?.pushViewController(playerVC, animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else {return}
        ApiManager.mediaLoad(dataType: "music", searchText: text) { (result) in
            switch result {
            case .success(let APImedia):
                self.media = APImedia.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
