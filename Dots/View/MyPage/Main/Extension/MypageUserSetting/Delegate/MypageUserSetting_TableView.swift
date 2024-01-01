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
        
        if indexPath.section == 0 {
//            let 스위치 = UISwitch()
//            스위치.isOn = 설정아이템.isSwitchOn
//            스위치.addTarget(self, action: #selector(프로필스위치변경), for: .valueChanged)
//            셀.accessoryView = 스위치
//            셀.selectionStyle = .none
            셀.layer.cornerRadius = 10
            
        } else if indexPath.section == 1 {
            셀.accessoryType = .disclosureIndicator
            셀.tintColor = UIColor.lightGray
            if indexPath.row == 0 {
                셀.layer.cornerRadius = 10
//                셀.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
        let cornerRadius: CGFloat = 10
        cell.backgroundColor = .clear

        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: 10, dy: 0)

        var addLine = false

        if indexPath.row == 0 && indexPath.row == 설정아이템들[indexPath.section].count - 1 {
            pathRef.addRoundedRect(in: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            addLine = true
        } else if indexPath.row == 설정아이템들[indexPath.section].count - 1 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
            addLine = true
        }

        layer.path = pathRef
        layer.fillColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor

        if addLine {
            let lineLayer = CALayer()
            let lineHeight = (1 / UIScreen.main.scale)
            lineLayer.frame = CGRect(x: bounds.minX + 10, y: bounds.size.height - lineHeight, width: bounds.size.width - 20, height: lineHeight)
            lineLayer.backgroundColor = tableView.separatorColor?.cgColor
            layer.addSublayer(lineLayer)
        }

        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = .clear
        cell.backgroundView = testView
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
        selectionStyle = .none

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(버튼_이름_라벨)

        // 폰트 설정
        버튼_이름_라벨.font = UIFont.systemFont(ofSize: 16) // 원하는 폰트와 크기로 변경

        // 오토레이아웃 설정
        버튼_이름_라벨.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30) // 왼쪽 여백
            make.centerY.equalToSuperview() // 세로 중앙 정렬
            // 추가적인 레이아웃 조건 설정 가능
        }
    }

    func configure(with title: String) {
        버튼_이름_라벨.text = title
        // 여기에서 추가적인 설정 가능, 예를 들어 글자 색상 변경 등
    }
}
