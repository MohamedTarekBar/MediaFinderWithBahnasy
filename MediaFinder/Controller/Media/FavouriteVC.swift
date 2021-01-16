//
//  FavouriteCV.swift
//  ToDoList
//
//  Created by MohamedTarek on 07/01/2021.
//

import UIKit

class FavouriteVC: UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var media :[Media]?
    let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getMediaFromHistory()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
         if tabBarIndex == 2 {
            getMediaFromHistory()
         }
    }
    
    func setup() {
        self.tabBarController?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layoutIfNeeded()
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
    }
    
    func getMediaFromHistory() {
        guard let email = DefaultManager.currentUser?.email else {return}
        media = LocalStorage.shared.getArrOfMedia(email: email)
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
}

extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        guard media != nil else {
            return UICollectionViewCell()
        }
        cell.imageView.downladImage(urlString: media![indexPath.row].artworkUrl100)
        cell.trackName.text = media![indexPath.row].trackName
        cell.descriptionLabel.text = media![indexPath.row].longDescription
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let kind = media![indexPath.row].kind else {return}
        guard let media = media else {return}
        if kind == dataType.music.rawValue {
            let playerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PlayerVC") as! PlayerVC
            playerVC.media = media[indexPath.row]
            self.navigationController?.pushViewController(playerVC, animated: true)
        }
        if kind == dataType.movie.rawValue || kind == dataType.tv.rawValue {
            mediaPlayer.media.playVideo(stringUrl: media[indexPath.row].previewUrl, self)
            mediaPlayer.media.PlayMedia(type: .movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width/2-5, height: self.collectionView.frame.height/2-5)
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
