class Image < ActiveRecord::Base
  # FORMATS = %w(jpeg jpg png)
  validates :link, uniqueness: true, presence: true
  validates :text, uniqueness: true, presence: true, length: { maximum: 400 }
  validate :check_image

  scope :published, -> { where(published: true) }

  def check_image
    begin
      img = Dragonfly.app.fetch_url(self.link)
      ext, width, height = img.ext, img.width, img.height
      self.sha = Digest::SHA1.hexdigest(img.data)
    rescue
      errors.add(:link, "Не получается найти изображение по ссылке =(")
    else
      errors.add(:link, "^Изображение слишком большое")  if width > 1000 || height > 600
      # errors.add(:link, "^Допустимые разрешения: #{FORMATS.join(", ")}")  if FORMATS.exclude?(ext)
      errors.add(:link, "^Такое изображение уже присутствует")  if Image.where(sha: self.sha).where.not(id: id).any?
    end
  end

  def self.add_images(text, ip)
    result = { i: 0, not_added: [] }
    text.each_line do |l|
      next  unless i_can_haz_link?(l)
      link = l.split.first
      text = l[/\s(.+)/].strip
      image = self.new(link: link, text: text, added_by: ip, published: true)
      image.save ? result[:i] += 1 : result[:not_added] << image
    end
    result
  end

  def self.for_autocomplete(term)
    self.published.where("text ILIKE ?", "%#{term}%").limit(10).map(&:text)
  end

  private

  def i_can_haz_link?(str)
    str =~ /^http\S+\s+.+$/
  end
end
