//
//  ProfileAccessoryController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 08/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary
import RxCocoa
import RxSwift
import AlamofireImage

protocol ProfileAccessoryController {}

extension ProfileAccessoryController {
    
    func profileAccessoryButton(for avatarId: String?, placeholder: UIImage = Asset.icProfilePlaceholder.image, action: Selector) -> UIBarButtonItem  {
        let profileAccessoryView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0))
        profileAccessoryView.contentMode = .scaleAspectFill
        
        //let filter = ScaledToSizeWithRoundedCornersFilter(size: CGSize(width: 35, height: 35), radius: 35.0 / 2)
        if let pictureId = avatarId {
            //profileAccessoryView.cldSetImage(pictureId, cloudinary: CLDCloudinary.shared, placeholder: placeholder)
            profileAccessoryView.af_setImage(withURL: URL(string: "https://res.cloudinary.com/do04iflqy/image/upload/v1556712935/user_avatars/hackerman.jpg")!)
        } else {
            profileAccessoryView.image = placeholder
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        profileAccessoryView.addGestureRecognizer(gestureRecognizer)
        
        return UIBarButtonItem(customView: profileAccessoryView)
    }
}
