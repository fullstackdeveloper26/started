//
//  STPhotoCell.swift
//  started
//
//  Created by Gabriel Pino on 9/26/21.
//

import UIKit
import SDWebImage

class STPhotoCell: UICollectionViewCell {
    var item: STImage?
    
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    func setData(_ item: STImage) {
        self.item = item
        
        self.lblTitle.text = item.title
        
        if let photoUrl = item.thumbnailUrl {
            imgPhoto.sd_setImage(with: URL(string: photoUrl), placeholderImage: UIImage(named: "placeholder"))
        }
        else {
            imgPhoto.image = UIImage(named: "placeholder")
        }
    }


}
