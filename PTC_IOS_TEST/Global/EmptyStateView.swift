//
//  EmptyStateView.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation
import Material

public protocol EmptyStateViewDelegate: class {
    func didTapTryAgain()
}

public class EmptyStateView: UIView, CodableView {
    public lazy var warningImage: UIImageView = UIImageView(image: R.image.iconWarning())
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Color.blue.base
        label.text = R.string.localizable.emptyStateView()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    public lazy var searchButton: UIButton = {
        let button = RaisedButton(title: R.string.localizable.emptyStateTryAgain(),
                                  titleColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.blue.base
        return button
    }()
    
    public weak var delegate: EmptyStateViewDelegate?
    
    override init(frame _: CGRect = .zero) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTapSearch() {
        delegate?.didTapTryAgain()
    }
    
    func configViews() {
        backgroundColor = .white
        searchButton.layer.cornerRadius = searchButton.bounds.width / 2
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }
    
    func buildViews() {
        addSubview(warningImage)
        addSubview(messageLabel)
        addSubview(searchButton)
    }
    
    func configConstraints() {
        warningImage.snp.makeConstraints {
            $0.height.width.equalTo(82)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(warningImage.snp.bottom).offset(27)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(45)
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
        }
    }
}
