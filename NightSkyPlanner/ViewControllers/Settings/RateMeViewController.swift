//
//  CoffeeViewController.swift
//  NightSkyPlanner
//
//  Created by Vic on 23.01.2026.
//

import UIKit
import SnapKit

final class RateMeViewController: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .lightGray
        label.text = "Night Sky Planner"
        return label
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
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(bottomStackView)
        
        topStackView.addArrangedSubview(titleLabel)
        bottomStackView.addArrangedSubview(closeButton)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
