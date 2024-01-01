import UIKit
extension 캘린더_스케쥴_등록_모달: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 셀_데이터_배열.셀_데이터_배열.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "캘린더_스케쥴_등록_셀", for: indexPath) as? 캘린더_스케쥴_등록_셀 else {
            return UITableViewCell()
        }
        
        let 데이터 = 셀_데이터_배열.셀_데이터_배열[indexPath.row]
        cell.전시_포스터_이미지(from: 데이터.포스터이미지URL)
        cell.전시명_라벨.text = 데이터.전시명
        cell.장소_라벨.text = 데이터.장소
        cell.방문날짜_라벨.text = 데이터.방문날짜
        if cell.isSelected {
            cell.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let 선택된데이터 = 셀_데이터_배열.셀_데이터_배열[indexPath.row]
        let 포스터스문서ID = 선택된데이터.포스터스문서ID

        // 모달을 닫고 네비게이션 진행
        self.dismiss(animated: true) {
            if let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController,
               let navVC = tabBarVC.selectedViewController as? UINavigationController {
                let 상세페이지뷰컨트롤러 = BackgroundImageViewController()
                상세페이지뷰컨트롤러.posterImageName = 포스터스문서ID
                
                navVC.pushViewController(상세페이지뷰컨트롤러, animated: true)
            }
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let 수정 = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            
        
            
            let 선택된데이터 = self.셀_데이터_배열.셀_데이터_배열[indexPath.row]
                
            if let 현제모달 = self.findViewController() {
                현제모달.dismiss(animated: true) {
                    let 새모달 = 켈린더_수정_뷰컨트롤러()
                    
                    새모달.수정할셀데이터 = 선택된데이터

                    새모달.modalPresentationStyle = .fullScreen
                    현제모달.present(새모달, animated: false, completion: nil)
                }
            }
            
            completionHandler(true)
        }
        수정.image = UIImage(named: "내후기edit")
        수정.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        
        let 삭제 = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
          
            
            let 선택된데이터 = self.셀_데이터_배열.셀_데이터_배열[indexPath.row]
             
            
            if let 현제모달 = self.findViewController() {
                현제모달.dismiss(animated: true) {
                    let 새모달 = 켈린더_삭제_뷰컨트롤러()
                    
                    새모달.삭제할셀데이터 = 선택된데이터

                    새모달.modalPresentationStyle = .fullScreen
                    현제모달.present(새모달, animated: false, completion: nil)
                    
                }
            }
            
            completionHandler(true)
        }
        삭제.image = UIImage(named: "내후기delete")
        삭제.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        
        let configuration = UISwipeActionsConfiguration(actions: [삭제, 수정])
        수정.accessibilityValue = "수정 버튼"
        삭제.accessibilityValue = "삭제 버튼"
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        tableView.separatorStyle = .none
    }
}

