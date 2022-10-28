//
//  SelectImagePopUpVC.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 29/07/22.
//

import UIKit
import SDWebImage
import PhotosUI

class SelectImagePopUpVC: BaseViewController {
    
    //MARK: - Properties
    @IBOutlet weak var mainView: ThemeView!
    @IBOutlet weak var collectionHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var imageData = [UIImage]()
    var clickEdit : ((UIImage)->())?
    var tabTypeSelection = SelectionBtn(rawValue: 0)
    var dismiss : (()->())?
    var pageTitle = "Select Image".localized
    
    //MARK: - Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        setUpUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let clickDismiss = dismiss {
            clickDismiss()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Custom method
    
    func setUpUI(){
        self.registerNib()
        self.lblTitle.text = pageTitle
        self.btnAddImage.setTitle("Add Images".localized, for: .normal)
        self.getImage()
    }
    
    func getImage(){
        let photo = PHAsset.fetchAssets(with: .image, options: nil)
        imageData.removeAll()
        for i in 0...photo.count - 1{
            imageData.append(getAssetThumbnail(asset: photo.object(at: i)))
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.width/2), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result ?? UIImage()
        })
        return thumbnail
    }
    
    func registerNib(){
        let nib = UINib(nibName: collectionPhotos.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionPhotos.className)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    // MARK: - IBAction methods
    @IBAction func BtnClosePopupAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddMoreImageClick(_ sender: Any) {
        let actionSheet = UIAlertController(title: "",
                                            message: "Select more photos or go to Settings to allow access to all photos.".localized,
                                                preferredStyle: .actionSheet)
            
        let selectPhotosAction = UIAlertAction(title: "Select more photos".localized,
                                                   style: .default) { [unowned self] (_) in
                    if #available(iOS 14, *) {
                        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
                    }
            }
            actionSheet.addAction(selectPhotosAction)
            
        let allowFullAccessAction = UIAlertAction(title: "Allow access to all photos".localized,
                                                      style: .default) { [unowned self] (_) in
                let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            actionSheet.addAction(allowFullAccessAction)
            
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true, completion: nil)
    }
}

extension SelectImagePopUpVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: collectionPhotos.className, for: indexPath)as! collectionPhotos
        cell.imgPhotos.image = imageData[indexPath.row]
        cell.imgPhotos.contentMode = .scaleAspectFill
        cell.btnCancel.isHidden = true
        cell.mainView.layer.cornerRadius = 8
        cell.mainView.layer.borderColor = UIColor.lightGray.cgColor
        cell.mainView.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let clicked = clickEdit {
            let cell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 0.1) {
                cell?.transform = CGAffineTransform(scaleX: 0, y: 0)
            } completion: { _ in
                cell?.transform = .identity
                self.dismiss(animated: true)
                clicked(self.imageData[indexPath.row])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3 - 5, height: collectionView.bounds.width/3 - 5)
    }
}
 
extension SelectImagePopUpVC: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async { [unowned self] in
            if #available(iOS 14, *) {
                getImage()
            }
        }
    }
}
