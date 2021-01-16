//
//  TableViewCell.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var backCellView: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageCellView: UIImageView!
    var media: Media?
    @IBOutlet weak var loveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    @IBAction func loveButtonTapped(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "heartFill"), for: .normal)
        guard let email = DefaultManager.currentUser?.email else {return}
        LocalStorage.shared.insertMedia(email: email, media: media!)
    }
    
    
}
