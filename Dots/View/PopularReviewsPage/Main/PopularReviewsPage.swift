// 인기 리뷰 뷰 컨트롤러
// 최신화 

import SnapKit
import UIKit

class PopularReviewsPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always

    }



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


        // 셀 사이의 경계선을 없애기

        tableView.separatorStyle = .none


        // UITableViewCell.self 대신 TweetTableViewCell.self로 변경해야 합니다.
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: "TweetTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell

        cell.backgroundColor = .black

        let tweetData = TweetData(
            profileImageName: "cabanel",
            userName: "cheshire",
            exhibitionName: "서울시립미술관",
            tweetImageName: "morningStar",
            tweetTitle: "전시 제목 입니다.",
            tweetContent: """
            오늘 전시회를 방문해서 정말 멋진 시간을 보냈습니다. 작품들은 아름답고 감동적이었고, 예술가들의 역량과 창의성에 감탄했습니다. 특히, 회화와 조각 작품들은 각기 다른 스타일과 표현력을 가지고 있어서 볼 때마다 새로운 감정을 느끼게 해주었습니다. 전시 공간 자체도 아주 아름다웠는데, 조명과 배치가 조화롭게 어우러져 작품들을 더욱 빛나게 했습니다. 또한, 전시 관람 도중 아티스트와 대화할 기회가 있어서 그들의 작업에 대한 인사이트를 얻을 수 있어서 특별한 경험이었습니다. 전시 후기를 쓰며, 예술의 아름다움과 힘을 다시 한 번 느낄 수 있었습니다. 이런 멋진 전시회를 기획하고 준비한 모든 분들에게 감사의 인사를 전하고 싶습니다. 더 많은 사람들이 이런 아름다운 예술을 만끽할 수 있기를 바랍니다.
            """,
            timeAgo: "8분전",
            additionalLabel1Text: "123",
            additionalLabel2Text: "456"
        )

        cell.configure(with: tweetData)
        return cell
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")

        let detailViewController = ReviewDetailViewController()
        detailViewController.hidesBottomBarWhenPushed = true

        // 다음 페이지로 넘어갈 때 대형 타이틀을 없애고 일반 타이틀로 전환
        detailViewController.navigationItem.largeTitleDisplayMode = .never

        navigationController?.pushViewController(detailViewController, animated: true)
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
    let timeLabel = UILabel()
    let titelLabel = UILabel()

    // 새로운 컴포넌트 선언
    let additionalImageView1 = UIImageView()
    let additionalLabel1 = UILabel()
    let additionalImageView2 = UIImageView()
    let additionalLabel2 = UILabel()

    let lineView = UIView()

    let moreLabel = UILabel()




    // 커스텀 셀의 기본 설정을 위한 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 컴포넌트 설정 및 레이아웃 구성


        addSubviews()
        setupLayout()

        // 새로운 컴포넌트 추가
        addAdditionalSubviews()
        setupAdditionalLayout()
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
        contentView.addSubview(timeLabel)
        contentView.addSubview(titelLabel)
        contentView.addSubview(moreLabel)

    }

    private func setupLayout() {
        // 프로필 이미지 뷰 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
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

        // "8분 전" 레이블 설정
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(exhibitionInfoLabel.snp.trailing).inset(10)
            make.centerY.equalTo(nameLabel)
        }



        // 피드 이미지 뷰 설정
        tweetImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.leading.equalTo(exhibitionInfoLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.height.equalTo(tweetImageView.snp.width)
        }

        titelLabel.snp.makeConstraints { make in
            make.top.equalTo(tweetImageView.snp.bottom).offset(10)
            make.leading.equalTo(tweetImageView.snp.leading)

        }

        // 트윗 내용 레이블 설정
        tweetContentLabel.snp.makeConstraints { make in
            make.top.equalTo(titelLabel.snp.bottom).offset(10)
            make.leading.equalTo(tweetImageView.snp.leading)
            make.trailing.equalTo(tweetImageView.snp.trailing)
            //            make.bottom.equalToSuperview().offset(-10)
        }
        tweetContentLabel.numberOfLines = 0


        // "더보기" 레이블 레이아웃 설정
        moreLabel.snp.makeConstraints { make in
            make.top.equalTo(tweetContentLabel.snp.bottom).offset(10)
            make.leading.equalTo(tweetContentLabel.snp.leading)
            make.trailing.equalTo(tweetContentLabel.snp.trailing)
        }
    }

    // 임시 데이터 바인딩을 위한 메서드
    func configure(with data: TweetData) {
        // 배경색 설정
        self.backgroundColor = UIColor.black

        // 프로필 이미지 설정 (이미지 이름은 프로젝트에 있는 이미지명과 일치해야 합니다)
//        profileImageView.image = UIImage(named: "cabanel")
        profileImageView.image = UIImage(named: data.profileImageName)

        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true

        // 유저 닉네임 레이블 설정
//        nameLabel.text = "cheshire"
        nameLabel.text = data.userName

        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold) // 폰트 크기와 두께 설정

        // 전시회 정보 레이블 설정
//        exhibitionInfoLabel.text = "국립현대미술관"
        exhibitionInfoLabel.text = data.exhibitionName

        exhibitionInfoLabel.textColor = UIColor.white
        exhibitionInfoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular) // 폰트 크기와 두께 설정

        // 피드 이미지 설정 (이미지 이름은 프로젝트에 있는 이미지명과 일치해야 합니다)
//        tweetImageView.image = UIImage(named: "morningStar")
        tweetImageView.image = UIImage(named: data.tweetImageName)

        let tweetContent = data.tweetContent // 데이터에서 트윗 내용을 가져옵니다.

        
        let moreText = "더보기..."
            let attributedString = NSMutableAttributedString(string: tweetContent)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.white
            ]

            attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))

            if attributedString.string.count > 100 { // 100자를 초과하는 경우에만 "더보기..." 추가
                attributedString.mutableString.setString(String(attributedString.string.prefix(100)) + "..." + moreText)
            }

            tweetContentLabel.attributedText = attributedString
            tweetContentLabel.numberOfLines = 3
            tweetContentLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
            tweetContentLabel.textColor = UIColor(red: 0.733, green: 0.733, blue: 0.733, alpha: 1)






        // "8분 전" 레이블 설정
        timeLabel.text = "8분 전"
        timeLabel.text = data.timeAgo

        timeLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        timeLabel.font = UIFont(name: "Pretendard-Light", size: 14)

//        titelLabel.text = "전시 후기 제목"
        titelLabel.text = data.tweetTitle

        titelLabel.textColor = .white
        titelLabel.font = UIFont(name: "Pretendard-Medium", size: 18)


        // 첫 번째 추가 이미지 뷰 및 레이블 구성
        additionalImageView1.image = UIImage(named: "Vector 3")

//        additionalLabel1.text = "123"
        additionalLabel1.text = data.additionalLabel1Text

        additionalLabel1.textColor = .white
        additionalLabel1.font = UIFont(name: "Pretendard-Light", size: 12)
        additionalLabel1.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        // 스타일 및 글꼴 설정 등

        // 두 번째 추가 이미지 뷰 및 레이블 구성
        additionalImageView2.image = UIImage(named: "streamline_interface-edit-view-eye-eyeball-open-view")
        additionalLabel2.textColor = .white
        additionalLabel2.font = UIFont(name: "Pretendard-Light", size: 12)
        additionalLabel2.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)


//        additionalLabel2.text = "456"
        additionalLabel2.text = data.additionalLabel2Text

        // 스타일 및 글꼴 설정 등


        // "더보기" 레이블 설정
        moreLabel.text = "더 보기"
        moreLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        moreLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        moreLabel.textAlignment = .left

        lineView.backgroundColor = UIColor(red: 0.237, green: 0.237, blue: 0.237, alpha: 1)


    }

    private func addAdditionalSubviews() {
        contentView.addSubview(additionalImageView1)
        contentView.addSubview(additionalLabel1)
        contentView.addSubview(additionalImageView2)
        contentView.addSubview(additionalLabel2)
        contentView.addSubview(lineView)
    }

    private func setupAdditionalLayout() {
        // 첫 번째 추가 이미지 뷰와 레이블 레이아웃
        additionalImageView1.snp.makeConstraints { make in
            make.top.equalTo(moreLabel.snp.bottom).offset(30)
            make.left.equalTo(tweetContentLabel.snp.left)
            make.width.equalTo(17.5)
            make.height.equalTo(14.5)
//            make.bottom.equalToSuperview().offset(-10)

        }

        additionalLabel1.snp.makeConstraints { make in
            make.centerY.equalTo(additionalImageView1)
            make.left.equalTo(additionalImageView1.snp.right).offset(10)
        }

        // 두 번째 추가 이미지 뷰와 레이블 레이아웃
        additionalImageView2.snp.makeConstraints { make in
            make.top.equalTo(moreLabel.snp.bottom).offset(25)
            make.left.equalTo(additionalLabel1.snp.right).offset(10)
            make.width.height.equalTo(24)
        }

        additionalLabel2.snp.makeConstraints { make in
            make.centerY.equalTo(additionalImageView2)
            make.left.equalTo(additionalImageView2.snp.right).offset(8)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(additionalImageView1.snp.bottom).offset(20)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()

        }


    }


}


struct TweetData {
    var profileImageName: String
    var userName: String
    var exhibitionName: String
    var tweetImageName: String
    var tweetTitle: String
    var tweetContent: String
    var timeAgo: String
    var additionalLabel1Text: String
    var additionalLabel2Text: String
}
