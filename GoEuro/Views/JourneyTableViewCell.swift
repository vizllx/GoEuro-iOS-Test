//
//  KEGJourneyTableViewCell.swift
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

import UIKit

private let timesLabelFontSize: CGFloat = 16

class JourneyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @objc internal static let defaultCellHeight: CGFloat = 130
    
    private let padding: CGFloat = 20
    
    internal let providerLogoSize: CGSize = {
        
        let string = NSAttributedString(string: "12:34 - 56:78", attributes: [ NSFontAttributeName : UIFont.goEuroFont(.Mono, size: timesLabelFontSize) ])
        let rect = string.boundingRectWithSize(CGSize(width: CGFloat.max, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil)
        
        return CGSize(width: ceil(rect.width), height: 40)
    }()
    
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
        label.font = UIFont.goEuroFont(.Mono, size: timesLabelFontSize)
        label.textColor = UIColor.goEuroFontColor()
        return label
    }()
    
    internal let journeyInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.goEuroFont(.Thin, size: 18)
        label.textColor = UIColor.goEuroFontColor()
        return label
    }()
    
    internal let durationLabel: UILabel = {
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
    
    // MARK: - Selected

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Layout
    
    private func setupView() {
        
        accessoryType = .DisclosureIndicator
        selectionStyle = .None
        
        addSubview(containerView)
        containerView.addSubview(providerLogoImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(timesLabel)
        containerView.addSubview(journeyInfoLabel)
        containerView.addSubview(durationLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxWidth = bounds.width
        let maxHeight = bounds.height
        
        let containerBounds = containerView.bounds
        
        containerView.frame = CGRect(x: padding, y: padding, width: maxWidth - (padding * 2), height: maxHeight - (padding * 2))
        
        providerLogoImageView.frame = CGRect(x: 0, y: 0, width: providerLogoSize.width, height: providerLogoSize.height)
        
        priceLabel.frame = CGRect(x: containerBounds.maxX - priceLabel.bounds.width - padding, y: 0, width: priceLabel.bounds.width, height: priceLabel.bounds.height)
        
        timesLabel.frame = CGRect(x: 0, y: containerBounds.height - timesLabel.bounds.height, width: timesLabel.bounds.width, height: timesLabel.bounds.height)
        
        durationLabel.frame = CGRect(x: containerBounds.maxX - durationLabel.bounds.width - padding, y: containerBounds.midY - durationLabel.bounds.midY, width: durationLabel.bounds.width, height: durationLabel.bounds.height)
        
        journeyInfoLabel.frame = CGRect(x: containerBounds.maxX - journeyInfoLabel.bounds.width - padding, y: containerBounds.maxY - journeyInfoLabel.bounds.height, width: journeyInfoLabel.bounds.width, height: journeyInfoLabel.bounds.height)
    }
}

