//
//  KEGJourneyTableViewCell.swift
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

import UIKit

class JourneyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let padding: CGFloat = 25
    
    internal let providerLogoSize = CGSize(width: 80, height: 40)
    
    internal let providerLogoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .ScaleAspectFit
        return view
    }()
    
    internal let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.goEuroFont(.Bold, size: 20)
        label.textColor = UIColor.goEuroFontColor()
        return label
    }()
    
    internal let timesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.goEuroFont(.Regular, size: 18)
        label.textColor = UIColor.goEuroFontColor()
        return label
    }()
    
    internal let journeyInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.goEuroFont(.Thin, size: 18)
        label.textColor = UIColor.goEuroFontColor()
        return label
    }()
    
    private let containerView = UIView()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Selected

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Layout
    
    private func setupView() {
        
        accessoryType = .DisclosureIndicator
        
        addSubview(containerView)
        containerView.addSubview(providerLogoImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(timesLabel)
        containerView.addSubview(journeyInfoLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxWidth = bounds.width
        let maxHeight = bounds.height
        
        containerView.frame = CGRect(x: padding, y: padding, width: maxWidth - (padding * 2), height: maxHeight - (padding * 2))
        
        providerLogoImageView.frame = CGRect(x: 0, y: 0, width: providerLogoSize.width, height: providerLogoSize.height)
        
        priceLabel.frame = CGRect(x: bounds.maxX - priceLabel.bounds.width, y: 0, width: priceLabel.bounds.width, height: priceLabel.bounds.height)
        
        timesLabel.frame = CGRect(x: 0, y: bounds.height - timesLabel.bounds.height, width: timesLabel.bounds.width, height: timesLabel.bounds.height)
        
        journeyInfoLabel.frame = CGRect(x: bounds.width - journeyInfoLabel.bounds.width, y: bounds.height - journeyInfoLabel.bounds.height, width: journeyInfoLabel.bounds.width, height: journeyInfoLabel.bounds.height)
    }
}

