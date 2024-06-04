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
        let activityIndicator: UIView?
        
        public init(
            screenTitle: String?,
            tableView: UIView,
            confirmButtonView: UIView?,
            activityIndicator: UIView?
        ) {
            self.screenTitle = screenTitle
            self.tableView = tableView
            self.confirmButtonView = confirmButtonView
            self.activityIndicator = activityIndicator
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
        addTableView()
        addConfirmButtonView()
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
    
    private func addTableView() {
        view.addSubview(viewProperties.tableView)
        viewProperties.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addConfirmButtonView() {
        guard let confirmButtonView = viewProperties.confirmButtonView else { return }
        
        view.addSubview(confirmButtonView)
        confirmButtonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addActivityIndicator() {
        guard let activityIndicator = viewProperties.activityIndicator else { return }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func backTapped() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}
