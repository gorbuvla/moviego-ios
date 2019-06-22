//
//  FlexibleCinemaHeader.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 22/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary
import RxCocoa

protocol FlexibleCinemaHeaderDelegate: class {
    func didTapNavigate()
    func didTapTaxi()
    func didTapWeb()
}

final class FlexibleCinemaHeader: FlexibleHeaderView {
    
    weak var thumbnailImage: UIImageView!
    weak var nameLabel: UILabel!
    weak var addressLabel: UILabel!
    weak var typesLabel: UILabel!
    
    weak var btnNavigate: UIButton!
    weak var btnTaxi: UIButton!
    weak var btnWeb: UIButton!
    
    var delegate: FlexibleCinemaHeaderDelegate?
    
    var cinema: Cinema? {
        didSet {
            guard let cinema = cinema else { return }
            
            nameLabel.text = cinema.name
            addressLabel.text = cinema.address
            typesLabel.text = cinema.types.joined(separator: ", ")
            
            thumbnailImage.cldSetImage(publicId: cinema.thumnailId ?? "", cloudinary: CLDCloudinary.shared, placeholder: Asset.imgCinemaThumbnailPlaceholder.image)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let _ = btnNavigate.rx.tap.bind(onNext: { [weak self] in self?.delegate?.didTapNavigate() })
        let _ = btnTaxi.rx.tap.bind(onNext: { [weak self] in self?.delegate?.didTapTaxi() })
        let _ = btnWeb.rx.tap.bind(onNext: { [weak self] in self?.delegate?.didTapWeb() })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getFlexibleView() -> UIView {
        let imageView = GradientImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        thumbnailImage = imageView
        return imageView
    }
    
    override func createCardContent(parent: UIView) {
        parent.ui.stack { it in
            it.axis = .vertical
            it.spacing = 12
            
            nameLabel = it.ui.label { it in
                it.textStyleDark(opacity: 1)
                it.styleHeading1()
            }
            
            addressLabel = it.ui.label { it in
                it.textStyleDark(opacity: 0.4)
                it.styleHeading3()
            }
            
            typesLabel = it.ui.label { it in
                it.textStyleDark(opacity: 0.5)
                it.styleHeading3()
            }
            
            it.ui.divider()
            
            it.ui.stack { it in
                it.axis = .horizontal
                it.distribution = .fillEqually
                
                btnNavigate = it.ui.button { it in
                    it.tintColor = .secondary
                    it.setBackgroundImage(UIColor.clear.image(), for: .normal)
                    it.setImage(Asset.icNavigation.image.withRenderingMode(.alwaysTemplate), for: .normal)
                }
                
                btnTaxi = it.ui.button { it in
                    it.tintColor = .secondary
                    it.setBackgroundImage(UIColor.clear.image(), for: .normal)
                    it.setImage(Asset.icTaxi.image.withRenderingMode(.alwaysTemplate), for: .normal)
                }
                
                btnWeb = it.ui.button { it in
                    it.tintColor = .secondary
                    it.setBackgroundImage(UIColor.clear.image(), for: .normal)
                    it.setImage(Asset.icWeb.image.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.bottom.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
}

class GradientImageView: UIImageView {
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        
        print("init with layer")
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.bkgLight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
