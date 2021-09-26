//
//  STPhotoVC.swift
//  started
//
//  Created by Gabriel Pino on 9/26/21.
//

import UIKit

class STPhotoVC: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var colPhotos: UICollectionView!

    var photos = [STImage]()
    var fetched = false
    var selectedPhoto: STImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        let photos = STImage.getPhotos()
        if photos.count > 0 {
            self.photos = Array(photos.filter { $0.id > 0 })
            // Show the loading progress
            loadingIndicator.stopAnimating()
        }
        else {
            // Show the loading progress
            loadingIndicator.startAnimating()
        }
        
        // call API anyway
        getPhotos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? STPhotoDetailVC {
            detailVC.selectedPhoto = self.selectedPhoto
        }
    }
    private func getPhotos() {
        ApiManager.sharedInstance.getPhotos(params: nil) { (photos, errorMsg) in
            DispatchQueue.main.async {

                // Hide the loading progress
                self.loadingIndicator.stopAnimating()

                if photos != nil {
                    self.photos.removeAll()
                    self.photos.append(contentsOf: photos!.filter { $0.id > 0 })
                    self.colPhotos.reloadData()
                    
                    self.fetched = true
                }
                else{
                    // Show the error message
                    let errorMessage = errorMsg ?? "Something went wrong, try again later"
                    self.showToast(message: errorMessage)
                }
            }
        }
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

// ----------------------------------
//  MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
//
extension STPhotoVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! STPhotoCell
        let photo = self.photos[indexPath.row]

        cell.setData(photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPhoto = self.photos[indexPath.row]
        self.performSegue(withIdentifier: "PhotoDetailSegue", sender: nil)
    }
    
}

