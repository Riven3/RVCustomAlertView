//
//  RVAlertView.swift
//  RVCustomAlertView
//
//  Created by 百年 on 2018/12/26.
//  Copyright © 2018年 百年. All rights reserved.
//

import UIKit

class RVAlertView: UIView,RVAlertAble {
    lazy var backView: UIView = UIView()
    
    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("RVALERT", for: UIControlState.normal)
        cancel.setTitleColor(.orange, for: UIControlState.normal)
        cancel.addTarget(self, action: #selector(dissMiss), for: UIControlEvents.touchUpInside)
        return cancel
    }()
    
    @objc func dissMiss(){
        self.dismiss()
    }
    
    func configSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 7
        layer.masksToBounds = true
        self.setupSubviews()
        self.snapSubviews()
    }
    
    func snapSubviews() {
        
        self.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.edges.equalTo(UIEdgeInsetsMake(20, 20, 20, 20))
        }
    }
    
    func setupSubviews(){
        addSubview(cancelButton)
    }
    
}
