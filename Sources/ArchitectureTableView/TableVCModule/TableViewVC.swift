//
//  TableViewVC.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit
import Architecture
import Components
import DesignSystem
import ImagesService

public final class TableViewVC: UIViewController, ViewProtocol {
    
    // MARK: - Public properties
    
    public struct ViewProperties {
        let screenTitle: String?
        let tableView: UIView
        let confirmButtonView: UIView?
        var shouldShowActivityIndicator: Bool
        
        public init(
            screenTitle: String?,
            tableView: UIView,
            confirmButtonView: UIView?,
            shouldShowActivityIndicator: Bool = false
        ) {
            self.screenTitle = screenTitle
            self.tableView = tableView
            self.confirmButtonView = confirmButtonView
            self.shouldShowActivityIndicator = shouldShowActivityIndicator
        }
    }
    
    // MARK: - Private properties
    
    public var viewProperties: ViewProperties
    
    // MARK: - UI
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Life cycle
    
    public init(
        viewProperties: ViewProperties
    ) {
        self.viewProperties = viewProperties
        super.init(nibName: nil, bundle: nil)
        addTableView(with: viewProperties)
        addConfirmButtonView(with: viewProperties)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    // MARK: - Public methods
    
    public func update(with viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
        viewProperties.shouldShowActivityIndicator ? showActivityIndicator() : hideActivityIndicator()
    }

    // MARK: - Private methods
    
    private func setupNavBar() {
        let barItem = UIBarButtonItem(
            image: .ic24ChevronLeft.withTintColor(.contentPrimary),
            style: .plain,
            target: self,
            action: #selector(backTapped))
        navigationItem.leftBarButtonItem = barItem
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backButtonTitle = nil
        
        title = viewProperties.screenTitle
    }
    
    private func showActivityIndicator() {
        guard !activityIndicator.isDescendant(of: view) else { return }
        
        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func hideActivityIndicator() {
        guard activityIndicator.isDescendant(of: view) else { return }
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func addTableView(with viewProperties: ViewProperties) {
        view.addSubview(viewProperties.tableView)
        viewProperties.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func addConfirmButtonView(with viewProperties: ViewProperties) {
        guard let confirmButtonView = viewProperties.confirmButtonView else { return }
        view.addSubview(confirmButtonView)
        confirmButtonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func backTapped() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}
