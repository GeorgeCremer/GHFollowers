//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by George Cremer on 25/03/2021.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageview = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String){
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        configureMessageLabel()
        configureLogoImageView()

    }
    
    private func configureMessageLabel(){
        addSubview(messageLabel)
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        
        ])
            
    }
    
    private func configureLogoImageView(){
        addSubview(logoImageview)
        logoImageview.image = Images.emptyStateLogo
        logoImageview.translatesAutoresizingMaskIntoConstraints = false

        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoBottomConstraint = logoImageview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageview.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            ])
        }
}
