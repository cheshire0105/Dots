import UIKit
import SnapKit
import Highcharts


class 회원가입_세번째_뷰컨트롤러 : UIViewController {
    let 아티스트_리스트 : [String] = ["살바도르 달리", "파블로 피카소", "뱅크시" , "클로드 모네","빈센트 반 고흐", "램브란트", "레오나르도 다 빈치","미켈란젤로", "뒤샹", "앤디 워홀" , "폴 세잔"]

    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    private let 건너뛰기_버튼 = {
        let button = UIButton()
        button.isSelected = !button.isSelected
        button.setTitle("건너뛰기", for: .normal)
        button.setTitle("건너뛰기", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "좋아하는 작가를 선택해주세요"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)

        return label
    } ()
    private let 검색_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 검색_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "직접입력...", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    private let 다음_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("다음", for: .normal)
        button.setTitle("다음", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()



    override func viewDidLoad() {
        view.backgroundColor = .black
        UI레이아웃 ()
        버튼_클릭()

        // Highcharts 차트 뷰 생성
        let chartView = HIChartView()
        chartView.backgroundColor = .clear
        self.view.addSubview(chartView)
        chartView.snp.makeConstraints { make in
            make.top.equalTo(검색_텍스트필드.snp.bottom).offset(20) // 텍스트 필드 바로 아래
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(다음_버튼.snp.top).offset(-20) // 다음 버튼 바로 위
        }
        let options = HIOptions()

        let chart = HIChart()
        chart.type = "bubble"
        chart.type = "packedbubble" // 'packedbubble' 차트 유형 사용
        chart.backgroundColor = HIColor(uiColor: .black) // 투명한 배경색 설정
        options.chart = chart


        // 레이아웃 알고리즘 커스텀
        let plotOptions = HIPlotOptions()
        plotOptions.packedbubble = HIPackedbubble()
        plotOptions.packedbubble.layoutAlgorithm = HILayoutAlgorithm()
        plotOptions.packedbubble.layoutAlgorithm.enableSimulation = true
        plotOptions.packedbubble.minSize = "70%" // 최소 버블 크기
        plotOptions.packedbubble.maxSize = "100%" // 최대 버블 크기
        options.plotOptions = plotOptions

        let title = HITitle()
        title.text = ""
        options.title = title

        // 축 설정
        let xAxis = HIXAxis()
        xAxis.visible = false // X 축 숨기기
        options.xAxis = [xAxis]

        let yAxis = HIYAxis()
        yAxis.visible = false // Y 축 숨기기
        options.yAxis = [yAxis]

        /// 햄버거바 숨기기
        let exporting = HIExporting()
        exporting.enabled = false
        options.exporting = exporting



        /// 타이틀 디자인
        let style = HICSSObject()
        title.style = style
        title.style.fontSize = "15"
        title.style.fontWeight = "bold"

        /// 카테고리 숨기기
        let legend = HILegend()
        legend.enabled = false
        options.legend = legend





        // 차트 데이터 설정
        let series = HISeries()
        series.data = (1...14).map { _ in
            // 세 가지 크기 중 하나를 랜덤으로 선택
            let size = [10000, 22500, 40000].randomElement()!
            
            return [Double.random(in: 0...100), Double.random(in: 0...100), size]
        }
        
        /// 크레딧 자리에 기준날짜 띄우기
        let credits = HICredits()
        credits.text = "아티스트는 항상 당신 곁에"
        options.credits = credits
        /// 동그라미 투명도 조절하기
        let marker = HIMarker()
        plotOptions.packedbubble.marker = marker
        plotOptions.packedbubble.marker.fillOpacity = 1
        


        // 데이터 라벨 설정
        let dataLabels = HIDataLabels()
        dataLabels.enabled = true
        dataLabels.format = "{point.name}" // 버블 이름으로 표시
        series.dataLabels = [dataLabels]

        options.series = [series]

        // 클릭 이벤트 설정
        let chartFunction = HIFunction(closure: { context in
            // 클릭 이벤트 처리 로직
        }, properties: ["this.index"])
        series.events = HIEvents()
        series.events.click = chartFunction



        // 차트 뷰에 옵션 설정 및 뷰에 추가
        chartView.options = options
        self.view.addSubview(chartView)
    }
}

extension 회원가입_세번째_뷰컨트롤러 {

    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(건너뛰기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(검색_백)
        view.addSubview(검색_텍스트필드)
        view.addSubview(다음_버튼)

        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        건너뛰기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(뒤로가기_버튼.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30)
        }
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(149)
            make.leading.equalToSuperview().offset(24)
        }
        검색_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)


        }
        검색_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(검색_백)
            make.leading.equalTo(검색_백.snp.leading).offset(30)
            make.trailing.equalTo(검색_백.snp.trailing).offset(-80)
            make.height.equalTo(56)

        }
        다음_버튼.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }


    }
}


extension 회원가입_세번째_뷰컨트롤러 {

    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        건너뛰기_버튼.addTarget(self, action: #selector(건너뛰기_버튼_클릭), for: .touchUpInside)
        다음_버튼.addTarget(self, action: #selector(다음_버튼_클릭), for: .touchUpInside)
    }


    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
    }
    @objc func 건너뛰기_버튼_클릭() {
        print("건 너 뛰 기")
        let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }

    @objc func 다음_버튼_클릭() {
        print("다음 페이지로 이동")
        let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
}





import SwiftUI
import AVFoundation
import SnapKit

// ReviewWritePage를 SwiftUI에서 미리 보기 위한 래퍼
struct 회원가입_세번째_뷰컨트롤러Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        // UINavigationController를 반환합니다.
        return UINavigationController(rootViewController: 회원가입_세번째_뷰컨트롤러())
    }

    func updateUIViewController(_ uiViewController: some UIViewController, context: Context) {
        // 뷰 컨트롤러 업데이트 시 수행할 작업, 필요한 경우에만 구현합니다.
    }
}

// SwiftUI 프리뷰
struct 회원가입_세번째_뷰컨트롤러Preview_Previews: PreviewProvider {
    static var previews: some View {
        회원가입_세번째_뷰컨트롤러Preview()
    }
}

