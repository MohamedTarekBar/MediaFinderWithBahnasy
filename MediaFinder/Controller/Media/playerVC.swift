//
//  playerVC.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit


class PlayerVC: UIViewController {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var media :Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyBoard()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    func setup() {
        guard let media = media else {
            return
        }
        labelView.text = media.artistName
        imageView.downladImage(urlString: media.artworkUrl100)
    }
    

    @IBAction func shareButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        guard let musicUrl = media?.previewUrl else {
            return
        }
        mediaPlayer.media.musicPlayer(stringUrl: musicUrl)
        mediaPlayer.media.PlayMedia(type: .song)
    }
    
    @IBAction func backwardButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func sliderChangedValue(_ sender: Any) {
        
    }
    
}
