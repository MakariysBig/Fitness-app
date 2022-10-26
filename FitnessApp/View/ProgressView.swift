import UIKit
import Then
import SnapKit

final class ProgressView: UIView {

    //MARK: - Internal properties

    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        $0.register(EmptyCustomCell.self, forCellReuseIdentifier: "EmptyCustomCell")
    }
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methodes
    
    private func setup() {
        backgroundColor = .greenCustomColor
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override methodes
    
    override func updateConstraints() {
        super.updateConstraints()
        
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
