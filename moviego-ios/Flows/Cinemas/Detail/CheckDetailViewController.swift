//
//  CheckDetailViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 22/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class CheckDetailViewController: UIViewController {
    
    //var imageView: UIImageView!
    //var layer: CALayer!
    var thumb: ThumbView!
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.darkGray
        tableView.delegate = self
        tableView.dataSource = self
        
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
//        header.backgroundColor = .green
//        tableView.tableHeaderView = header
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        view.addSubview(tableView)
        
        thumb = ThumbView()
        thumb.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        view.addSubview(thumb)
        
//        imageView = UIImageView(image: Asset.imgHeaderPlaceholder.image)
//        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        view.addSubview(imageView)
//
//        let layer = CAGradientLayer()
//        layer.colors = [UIColor.clear.cgColor, UIColor.green.cgColor]
//        layer.startPoint = CGPoint(x: 0, y: 0)
//        layer.endPoint = CGPoint(x: 0, y: 1)
//        layer.frame = imageView.bounds
//
//
//        imageView.layer.addSublayer(layer)

    }
    
}

class ThumbView: BaseView {
    
    var imageView: UIImageView!
    var gradientLayer: CAGradientLayer!
    
    override func createView() {
        backgroundColor = .bkgLight
        
        
        
        imageView = ui.customView(GradientImageView(frame: .zero)) { it in
            it.contentMode = .scaleAspectFill
            it.clipsToBounds = true
            it.backgroundColor = .yellow
            it.image = Asset.imgHeaderPlaceholder.image
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.width.equalToSuperview()
                //make.height.equalTo(200)
            }
        }
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.bkgLight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = imageView.bounds
        //gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        
        imageView.layer.addSublayer(gradientLayer)
        
        ui.view { it in
            it.layer.cornerRadius = 6
            it.layer.borderColor = UIColor.black.cgColor
            it.layer.borderWidth = 2
            it.clipsToBounds = true
            it.backgroundColor = UIColor.white
            
            it.ui.label { it in
                it.text = "Cinema"
                
                it.snp.makeConstraints { make in
                    make.top.bottom.leading.trailing.equalToSuperview().inset(20)
                }
            }
            
            it.snp.makeConstraints { make in
                make.centerY.equalTo(imageView.snp.bottom)
                make.leading.trailing.equalTo(safeArea).inset(20)
                //make.height.equalTo(100)
                make.bottom.equalToSuperview().inset(20)
            }
        }
        
    }
    
    override func layoutSubviews() {
        //gradientLayer.frame = imageView.bounds
        super.layoutSubviews()
    }
    
    
}

extension CheckDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        cell.textLabel?.text = "Text"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        
//        thumb.imageView.snp.updateConstraints { make in
//            make.height.equalTo(-scrollView.contentOffset.y - 100)
//            //thumb.gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: -scrollView.contentOffset.y - 100)
//        }
        thumb.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: -scrollView.contentOffset.y)
    }
}

class GradientImageView: UIImageView {
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        
        print("Inited with layer")
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.bkgLight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
