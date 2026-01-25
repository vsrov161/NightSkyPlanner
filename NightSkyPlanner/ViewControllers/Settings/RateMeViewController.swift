//
//  CoffeeViewController.swift
//  NightSkyPlanner
//
//  Created by Vic on 23.01.2026.
//

import UIKit
import SnapKit

final class RateMeViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .lightGray
        label.text = "Night Sky Planner"
        return label
    }()
    
    private lazy var rateButton: UIButton = {
        
        var config = UIButton.Configuration.bordered()
        config.title = "⭐ Rate on GitHub"
        
        let button  = UIButton(configuration: config, primaryAction: nil)
        
        button.addTarget(self, action: #selector(openGitHub), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        
        var config = UIButton.Configuration.borderedTinted()
        config.title = "Close"
        
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let button = UIButton(configuration: config, primaryAction: action)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        let contentStack = UIStackView(arrangedSubviews: [
            titleLabel,
            rateButton,
            closeButton
        ])
        
        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.alignment = .center
        contentStack.distribution = .fill
        
        view.addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(14)
        }
        
        rateButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalToSuperview()
        }
        
    }
    
    // MARK: Actions
    @objc private func openGitHub() {
        guard let url = URL(string: "https://github.com/vsrov161/NightSkyPlanner"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url)
        print("github button worked")
        
        self.dismiss(animated: false)
    }
}
