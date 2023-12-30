import UIKit

extension 마이페이지_설정_페이지 : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 설정아이템들.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 설정아이템들[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let 셀 = tableView.dequeueReusableCell(withIdentifier: "설정_셀", for: indexPath) as! 설정_셀
        let 설정아이템 = 설정아이템들[indexPath.section][indexPath.row]
        
        셀.configure(with: 설정아이템.title)
        셀.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let 스위치 = UISwitch()
            스위치.isOn = 설정아이템.isSwitchOn
            스위치.addTarget(self, action: #selector(프로필스위치변경), for: .valueChanged)
            셀.accessoryView = 스위치
            셀.selectionStyle = .none
            셀.layer.cornerRadius = 10
            
        } else if indexPath.section == 1 {
            셀.accessoryType = .disclosureIndicator
            셀.tintColor = UIColor.lightGray
            if indexPath.row == 0 {
                셀.layer.cornerRadius = 10
                셀.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == 3 {
                셀.layer.cornerRadius = 10
                셀.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }  else if indexPath.section == 2 && indexPath.row == 0{
            셀.layer.cornerRadius = 10
            
        }
        else {
            셀.accessoryType = .none
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            셀.버튼_이름_라벨.textColor = .red
            셀.selectionStyle = .none
            셀.layer.cornerRadius = 10
        }
        return 셀
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //           설정아이템들[indexPath.section][indexPath.row].action()
        
        let selectedCell = (tableView.cellForRow(at: indexPath) as? 설정_셀)!
        셀_클릭(for: selectedCell)
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return " "
        case 2:
            return " "
        case 3:
            return " "
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 || section == 2 || section == 3 {
            view.tintColor = .clear
        } else {
            view.tintColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3 , indexPath.section == 1 && indexPath.row == 3 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        if indexPath.row == 설정아이템들[indexPath.section].count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tabBarController?.tabBar.isHidden = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tabBarController?.tabBar.isHidden = true
    }
    
}

class 설정_셀: UITableViewCell {
    
    let 버튼_이름_라벨 = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(버튼_이름_라벨)
        
        버튼_이름_라벨.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with title: String) {
        버튼_이름_라벨.text = title
    }
}


