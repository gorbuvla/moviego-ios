//
//  CinemaBottomSheetView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary
import RxSwift
import RxCocoa

protocol CinemaBottomSheetDelegate {
    func didTapDetail()
}

class CinemaBottomSheetView: BaseView {
    
    private weak var header: CinemaCardHeader!
    private weak var footer: CinemaCardFooter!
    
    var delegate: CinemaBottomSheetDelegate?
    
    var cinema: Cinema? {
        didSet {
            guard let cinema = cinema else { return }
            
            // header setup
            header.titleLabel.text = cinema.name
            header.addressLabel.text = cinema.address
            header.typesLabel.text = "Standard, 3D, 4DX, IMAX" // TODO: actual
            header.thumbnailImage.cldSetImage(cinema.thumnailId ?? "", cloudinary: CLDCloudinary.shared, placeholder: Asset.imgCinemaThumbnailPlaceholder.image)
            
            // footer setup
            footer.viewModel = CinemaCardFooter.ReferenceMovieViewModel(movies: cinema.topMovies)
            let _ = footer.detailButton.rx.tap
                .bind(onNext: {
                    self.delegate?.didTapDetail()
                })
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyShadow()
    }
    
    override func createView() {
        backgroundColor = .white
        layer.cornerRadius = 4
        clipsToBounds = true
        
        header = ui.customView(CinemaCardHeader()) { it in
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(12)
                make.width.equalToSuperview()
            }
        }
        
        let divider = ui.view { it in
            it.backgroundColor = .separator
            
            it.snp.makeConstraints { make in
                make.top.equalTo(header.snp.bottom).offset(12)
                make.leading.trailing.equalToSuperview().inset(12)
                make.height.equalTo(1)
            }
        }
        
        footer = ui.customView(CinemaCardFooter()) { it in
            it.snp.makeConstraints { make in
                make.top.equalTo(divider.snp.bottom).offset(12)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}

private class CinemaCardHeader: BaseView {
    
    weak var thumbnailImage: UIImageView!
    weak var titleLabel: UILabel!
    weak var addressLabel: UILabel!
    weak var typesLabel: UILabel!
    
    override func createView() {
        thumbnailImage = ui.imageView { it in
            it.layer.cornerRadius = 4
            it.clipsToBounds = true
            
            it.snp.makeConstraints { make in
                make.width.equalTo(120)
                make.height.equalTo(it.snp.width).multipliedBy(0.5)
                make.top.leading.bottom.equalToSuperview()
            }
        }
        
        ui.stack { it in
            it.axis = .vertical
            it.distribution = .fillProportionally
            
            titleLabel = it.ui.label { it in
                it.styleHeading2()
                it.textStyleDark()
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            addressLabel = it.ui.label { it in
                it.styleHeading3()
                it.textStyleDark(opacity: 0.4)
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            typesLabel = it.ui.label { it in
                it.styleHeading3()
                it.textStyleDark(opacity: 0.4)
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.leading.equalTo(thumbnailImage.snp.trailing).inset(-10)
                make.top.trailing.bottom.equalToSuperview()
            }
        }
    }
}

private class CinemaCardFooter: BaseView {
    
    class ReferenceMovieViewModel: NSObject, UICollectionViewDataSource {
        
        private let movies: [Movie]
        
        init(movies: [Movie]) {
            self.movies = movies
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let movie = movies[safe: indexPath.item] else { return UICollectionViewCell() }
            
            let cell: ReferenceMovieCell = collectionView.dequeueCell(for: indexPath)
            cell.movie = movie
            return cell
        }
    }
    
    private class ReferenceMovieCell: UICollectionViewCell {
        
        weak var thumbnail: UIImageView!
        
        var movie: Movie? {
            didSet {
                guard let movie = movie else { return }
                
                thumbnail.af_setImage(withURL: movie.poster) // TODO: handle error
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            thumbnail = ui.imageView { it in
                it.layer.cornerRadius = 4
                it.clipsToBounds = true
                it.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    weak var collectionView: UICollectionView!
    weak var detailButton: UIButton!
    
    var viewModel: ReferenceMovieViewModel? {
        didSet {
            collectionView.dataSource = viewModel
            collectionView.reloadData()
        }
    }
    
    override func createView() {
        clipsToBounds = true
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.minimumLineSpacing = 8
        collectionFlowLayout.itemSize = CGSize(width: 60, height: 80)
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        collectionView = ui.collectionView(frame: .zero, flowLayout: collectionFlowLayout) { it in
            it.showsHorizontalScrollIndicator = false
            it.backgroundColor = .white
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(80)
            }
        }
        
        detailButton = ui.button { it in
            it.setTitle(L10n.Cinema.Map.BottomSheet.Button.title.uppercased(), for: .normal)
            it.accentButton()
            
            it.snp.makeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom).offset(8)
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(40)
                make.width.equalToSuperview()
            }
        }
    }
}
