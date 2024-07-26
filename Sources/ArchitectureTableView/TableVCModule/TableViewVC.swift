import UIKit
import SnapKit
import Architecture
import ImagesService
import Colors
import Components

public final class TableViewVC: UIViewController, ViewProtocol {
    
    // MARK: - Public properties
    
    public struct ViewProperties {
        public var navigationBarViewProperties: NavigationBar.ViewProperties
        public var tableView: UIView
        public var confirmButtonView: UIView?
        public var activityIndicator: UIView?
        
        public init(
            navigationBarViewProperties: NavigationBar.ViewProperties,
            tableView: UIView,
            confirmButtonView: UIView? = nil,
            activityIndicator: UIView? = nil
        ) {
            self.navigationBarViewProperties = navigationBarViewProperties
            self.tableView = tableView
            self.confirmButtonView = confirmButtonView
            self.activityIndicator = activityIndicator
        }
    }
    
    // MARK: - Private properties
    
    public var viewProperties: ViewProperties
    
    // MARK: - Life cycle
    
    public init(
        viewProperties: ViewProperties
    ) {
        self.viewProperties = viewProperties
        
        super.init(nibName: nil, bundle: nil)
        
        addTableView()
        addConfirmButtonView()
        addActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    // MARK: - Public methods
    
    public func update(with viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
    }

    // MARK: - Private methods
    
    private func setupNavigationBar() {
        let navigationBar = navigationController as? NavigationBar
        navigationBar?.update(with: viewProperties.navigationBarViewProperties)
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
