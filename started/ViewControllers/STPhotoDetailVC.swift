//
//  STPhotoDetailVC.swift
//  started
//
//  Created by Gabriel Pino on 9/26/21.
//

import UIKit

class STPhotoDetailVC: UIViewController {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    var selectedPhoto: STImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if(selectedPhoto != nil) {
            self.lblTitle.text = selectedPhoto!.title
            if let photoUrl = selectedPhoto!.url {
                imgPhoto.sd_setImage(with: URL(string: photoUrl), placeholderImage: UIImage(named: "placeholder"))
            }
            else {
                imgPhoto.image = UIImage(named: "placeholder")
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
