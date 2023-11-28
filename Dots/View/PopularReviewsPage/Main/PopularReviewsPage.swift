// 인기 리뷰 뷰 컨트롤러

import SnapKit
import UIKit

class PopularReviewsPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        view.backgroundColor = .black

    }

    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black

        // UITableViewCell.self 대신 TweetTableViewCell.self로 변경해야 합니다.
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // Constraints 설정
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func setupNavigationBar() {
        // 네비게이션 타이틀 설정
        self.navigationItem.title = "인기"
        // 네비게이션 바 배경색과 타이틀 색상 설정
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black // 배경색을 검은색으로 설정
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 타이틀을 하얀색으로 설정
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // 대형 타이틀도 하얀색으로 설정

        // iOS 15 이상에서는 아래 설정도 필요할 수 있습니다.
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance

        // 네비게이션 바 대형 타이틀 설정
        navigationController?.navigationBar.prefersLargeTitles = true // 대형 타이틀 활성화
    }



    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 여기에는 셀의 개수를 반환
        return 10 // 예시
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 커스텀 셀로 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        // 셀에 임시 데이터를 바인딩
        cell.configure()
        return cell
    }

    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 시 동작
        print("Selected row: \(indexPath.row)")
    }

    // UITableViewDelegate
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false // 셀 하이라이트를 꺼줍니다.
    }

}


import SnapKit

class TweetTableViewCell: UITableViewCell {
    // UI 컴포넌트들을 여기에 선언
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let exhibitionInfoLabel = UILabel()
    let tweetImageView = UIImageView()
    let tweetContentLabel = UILabel()

    // 커스텀 셀의 기본 설정을 위한 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 컴포넌트 설정 및 레이아웃 구성
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        // 각 컴포넌트를 contentView에 추가
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(exhibitionInfoLabel)
        contentView.addSubview(tweetImageView)
        contentView.addSubview(tweetContentLabel)
    }

    private func setupLayout() {
        // 프로필 이미지 뷰 설정
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
        }
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true

        // 유저 닉네임 레이블 설정
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.top.equalTo(profileImageView)
            make.right.equalToSuperview().offset(-10)
        }

        // 전시회 정보 레이블 설정
        exhibitionInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.right.equalTo(nameLabel)
        }

        // 피드 이미지 뷰 설정
        tweetImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.leading.equalTo(exhibitionInfoLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.height.equalTo(tweetImageView.snp.width)
        }

        // 트윗 내용 레이블 설정
        tweetContentLabel.snp.makeConstraints { make in
            make.top.equalTo(tweetImageView.snp.bottom).offset(10)
            make.leading.equalTo(tweetImageView.snp.leading)
            make.trailing.equalTo(tweetImageView.snp.trailing)
            make.bottom.equalToSuperview().offset(-10)
        }
        tweetContentLabel.numberOfLines = 0
    }

    // 임시 데이터 바인딩을 위한 메서드
    func configure() {
        // 배경색 설정
        self.backgroundColor = UIColor.black

        // 프로필 이미지 설정 (이미지 이름은 프로젝트에 있는 이미지명과 일치해야 합니다)
        profileImageView.image = UIImage(named: "cabanel")
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true

        // 유저 닉네임 레이블 설정
        nameLabel.text = "cheshire"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold) // 폰트 크기와 두께 설정

        // 전시회 정보 레이블 설정
        exhibitionInfoLabel.text = "국립현대미술관"
        exhibitionInfoLabel.textColor = UIColor.white
        exhibitionInfoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular) // 폰트 크기와 두께 설정

        // 피드 이미지 설정 (이미지 이름은 프로젝트에 있는 이미지명과 일치해야 합니다)
        tweetImageView.image = UIImage(named: "morningStar")

        // 트윗 내용 레이블 설정
        tweetContentLabel.text = """
오늘 전시회를 방문해서 정말 멋진 시간을 보냈습니다. 작품들은 아름답고 감동적이었고, 예술가들의 역량과 창의성에 감탄했습니다. 특히, 회화와 조각 작품들은 각기 다른 스타일과 표현력을 가지고 있어서 볼 때마다 새로운 감정을 느끼게 해주었습니다. 전시 공간 자체도 아주 아름다웠는데, 조명과 배치가 조화롭게 어우러져 작품들을 더욱 빛나게 했습니다. 또한, 전시 관람 도중 아티스트와 대화할 기회가 있어서 그들의 작업에 대한 인사이트를 얻을 수 있어서 특별한 경험이었습니다. 전시 후기를 쓰며, 예술의 아름다움과 힘을 다시 한 번 느낄 수 있었습니다. 이런 멋진 전시회를 기획하고 준비한 모든 분들에게 감사의 인사를 전하고 싶습니다. 더 많은 사람들이 이런 아름다운 예술을 만끽할 수 있기를 바랍니다.
"""
        tweetContentLabel.textColor = UIColor.white
        tweetContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular) // 폰트 크기와 두께 설정
        tweetContentLabel.numberOfLines = 0
    }

}
