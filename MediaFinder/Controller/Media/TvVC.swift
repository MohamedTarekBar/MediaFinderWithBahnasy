//
//  TvVC.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit
import SDWebImage

class TvVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cellReuseIdentifier = "tableViewCell"
    let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
    var media:[Media] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

extension TvVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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
            cell.labelView.text = media[indexPath.row].longDescription
            cell.imageView?.downladImage(urlString: media[indexPath.row].artworkUrl100)

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mediaPlayer.media.playVideo(stringUrl: media[indexPath.row].previewUrl, self)
        mediaPlayer.media.PlayMedia(type: .movie)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else {return}
        ApiManager.mediaLoad(dataType: "tvShow", searchText: text) { (result) in
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

