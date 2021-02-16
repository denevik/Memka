//		
//  Memka
//	

import PinLayout

/// The cell to display meme.
class MemeListCell: UICollectionViewCell {

  // MARK: - Constants

  static let identifier = String(describing: MemeListCell.self)

  // MARK: - UI Elements

  /// Topic title before the `memeImageView`.
  private let titleLabel = UILabel()

  /// Meme image.
  private let memeImageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    style()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - SSL

  func setup() {
    addSubview(titleLabel)
    addSubview(memeImageView)
  }

  func style() {
    MemeListCell.styleTitleLabel(titleLabel)
    MemeListCell.styleMemesImageView(memeImageView)
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    memeImageView.image = nil
    titleLabel.text = ""
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    titleLabel.pin
      .top(10)
      .hCenter()
      .width(90%)
      .sizeToFit(.width)

    memeImageView.pin
      .below(of: titleLabel)
      .marginTop(10)
      .left(10)
      .right(10)
      .bottom(10)
  }

  func configure(with item: Models.App.MemeList.Meme) {
    titleLabel.text = item.title
    memeImageView.image = item.image
  }
}

// MARK: Styling Functions

private extension MemeListCell {
  static func styleTitleLabel(_ label: UILabel) {
    label.textAlignment = .center
    label.numberOfLines = 0
  }

  static func styleMemesImageView(_ memesImageView: UIImageView) {
    memesImageView.contentMode = .scaleAspectFit
    memesImageView.layer.borderWidth = 1
    memesImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
  }
}

