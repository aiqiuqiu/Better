//
//  HynImagePickerViewController.swift
//  Better
//
//  Created by Huang Yanan on 2016/11/7.
//  Copyright © 2016年 Huang Yanan. All rights reserved.
//

import UIKit
import Photos

class HynImagePickerNavController: HynNavController {
    
    var limitMaxCout:Int = 9 {
        didSet {
            photosViewController.limitMaxCout = limitMaxCout
        }
    }
    
    fileprivate lazy var photosViewController:HynPhotosViewController = {
        let vc = HynPhotosViewController()
        return vc
    }()
    
    
    /// 选中的照片
    var imagesDidSelected:((_ selectedAsset:[PHAsset])->())?
    
    typealias cameraImageClosure = (_ image:UIImage)->()
    private var cameraImage:cameraImageClosure?
    
    
    /// 相机照片
    ///
    /// - Parameter image: 相机照片
    func requestCameraImage(image:@escaping cameraImageClosure) {
        cameraImage = image
    }
    

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = HynThemeManager.shared.backgroundColor
            
        self.setViewControllers([(self.photosViewController)], animated: true)
        self.photosViewController.imagesDidSelected = {
            guard (self.imagesDidSelected != nil) else {
                return
            }
            self.imagesDidSelected!($0)
        }
        self.photosViewController.requestCameraImage(image: { [weak self] (image) in
            self?.cameraImage!(image)
        })
        
    }

}
