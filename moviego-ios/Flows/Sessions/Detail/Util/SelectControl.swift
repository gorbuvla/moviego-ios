//
//  SelectControl.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

//
// Base Control that shows current sleection.
//
class SelectControl<T>: UIControl {
    
    private weak var emptyView: UIView!
    private weak var selectionView: UIView!
    
    open var emptyText: String? {
        get { return nil }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
        itemSelected(item: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func itemSelected(item: T?) {
        emptyView.isHidden = item != nil
        selectionView.isHidden = item == nil
    }
    
    open func createContent() -> UIView {
        return UIView()
    }
    
    private func createView() {
        backgroundColor = .white
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = UIColor.separator.cgColor
        clipsToBounds = true
        
        emptyView = ui.label { it in
            it.text = emptyText
            it.textAlignment = .center
            it.textStyleDark()
            it.styleHeading3()
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        selectionView = ui.customView(createContent()) { it in
            it.isHidden  = true
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(12)
            }
        }
    }
}
