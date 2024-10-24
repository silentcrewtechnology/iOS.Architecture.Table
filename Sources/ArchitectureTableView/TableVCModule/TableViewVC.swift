import UIKit
import SnapKit
import Architecture
import ImagesService
import Colors
import Components

public final class TableViewVC: UIViewController, ViewProtocol {
    
    // MARK: - Public properties
    
    public struct ViewProperties {
        public var navigationBarViewProperties: NavigationBar.ViewProperties?
        public var tableView: UIView
        public var confirmButtonView: UIView?
        public var activityIndicator: UIView?
        public var backgroundColor: UIColor
        public var lifeCycle: LifeCycle?
        
        public init(
            navigationBarViewProperties: NavigationBar.ViewProperties? = nil,
            tableView: UIView,
            confirmButtonView: UIView? = nil,
            activityIndicator: UIView? = nil,
            backgroundColor: UIColor = .white,
            lifeCycle: LifeCycle? = nil
        ) {
            self.navigationBarViewProperties = navigationBarViewProperties
            self.tableView = tableView
            self.confirmButtonView = confirmButtonView
            self.activityIndicator = activityIndicator
            self.backgroundColor = backgroundColor
            self.lifeCycle = lifeCycle
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
        
        addTableView(viewProperties: viewProperties)
        addConfirmButtonView(viewProperties: viewProperties)
        addActivityIndicator(viewProperties: viewProperties)
        setupNavigationBar(viewProperties: viewProperties)
        
        viewProperties.lifeCycle?.onInit?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = viewProperties.backgroundColor
        viewProperties.lifeCycle?.onViewDidLoad?()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(viewProperties: viewProperties)
        viewProperties.lifeCycle?.onViewWillAppear?()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        viewProperties.lifeCycle?.onViewIsAppearing?()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewProperties.lifeCycle?.onViewWillLayoutSubViews?()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewProperties.lifeCycle?.onViewDidLayoutSubviews?()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewProperties.lifeCycle?.onViewDidAppear?()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewProperties.lifeCycle?.onViewWillDisappear?()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewProperties.lifeCycle?.onViewDidDisappear?()
    }
    
    deinit {
        viewProperties.lifeCycle?.onDeinit?()
    }
    
    // MARK: - Public methods
    
    public func update(with viewProperties: ViewProperties) {
        updateTableViewIfNeeded(newViewProperties: viewProperties)
        updateConfirmButtonIfNeeded(newViewProperties: viewProperties)
        updateActivityIndicatorIfNeeded(newViewProperties: viewProperties)
        updateNavigationBarIfNeeded(newViewProperties: viewProperties)
        
        view.backgroundColor = viewProperties.backgroundColor
        self.viewProperties = viewProperties
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar(viewProperties: ViewProperties) {
        guard let navigationBarViewProperties = viewProperties.navigationBarViewProperties
        else { return }
        
        let navigationBar = navigationController as? NavigationBar
        navigationBar?.update(with: navigationBarViewProperties)
    }
    
    private func updateNavigationBarIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.navigationBarViewProperties != viewProperties.navigationBarViewProperties,
              let navigationBarViewProperties = newViewProperties.navigationBarViewProperties
        else { return }
        
        let navigationBar = navigationController as? NavigationBar
        navigationBar?.update(with: navigationBarViewProperties)
    }
    
    private func addTableView(viewProperties: ViewProperties) {
        addTableViewAndMakeConstraints(with: viewProperties.tableView)
    }
    
    private func updateTableViewIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.tableView != viewProperties.tableView else { return }
        
        viewProperties.tableView.snp.removeConstraints()
        viewProperties.tableView.removeFromSuperview()
        
        addTableViewAndMakeConstraints(with: newViewProperties.tableView)
    }
    
    private func addTableViewAndMakeConstraints(with tableView: UIView) {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addConfirmButtonView(viewProperties: ViewProperties) {
        guard let confirmButtonView = viewProperties.confirmButtonView else { return }
        
        addConfirmButtonAndMakeConstraints(with: confirmButtonView)
        remakeTableViewConstraints(with: viewProperties.tableView, button: confirmButtonView)
    }
    
    private func updateConfirmButtonIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.confirmButtonView != viewProperties.confirmButtonView,
              let confirmButtonView = newViewProperties.confirmButtonView
        else { return }
        
        viewProperties.confirmButtonView?.snp.removeConstraints()
        viewProperties.confirmButtonView?.removeFromSuperview()
        
        addConfirmButtonAndMakeConstraints(with: confirmButtonView)
        remakeTableViewConstraints(with: viewProperties.tableView, button: confirmButtonView)
    }
    
    private func addConfirmButtonAndMakeConstraints(with button: UIView) {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func remakeTableViewConstraints(with tableView: UIView, button: UIView) {
        tableView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(button.snp.top).inset(-16)
        }
    }
    
    private func addActivityIndicator(viewProperties: ViewProperties) {
        guard let loader = viewProperties.activityIndicator else { return }
        
        addLoaderAndMakeConstraints(with: loader)
    }
    
    private func updateActivityIndicatorIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.activityIndicator != viewProperties.activityIndicator,
              let loader =  newViewProperties.activityIndicator
        else { return }
        
        viewProperties.activityIndicator?.snp.removeConstraints()
        viewProperties.activityIndicator?.removeFromSuperview()
        
        addLoaderAndMakeConstraints(with: loader)
    }
    
    private func addLoaderAndMakeConstraints(with loader: UIView) {
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
