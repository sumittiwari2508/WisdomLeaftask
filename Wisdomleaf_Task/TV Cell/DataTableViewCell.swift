//
//  DataTableViewCell.swift
//  Wisdomleaf_Task
//
//  Created by $umit on 15/05/23.
//

import UIKit
import Kingfisher

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var infoData: DataModel?{
        didSet{
            guard let infoData = infoData else { return }
            titleLbl.text = infoData.author
            descLbl.text = infoData.url
            img.kf.setImage(with: URL(string: infoData.downloadURL ?? ""), placeholder: UIImage(named: "image-placeholder"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
