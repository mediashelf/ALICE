class Page < ActiveRecord::Base
  attr_accessible :title, :body, :position, :parent_id, :slug

  has_many :children, class_name: Page, foreign_key: 'parent_id', order: 'position'
  belongs_to :parent, class_name: Page
  acts_as_list scope: :parent

  validates :title, :body, :slug, presence: true
  validate :cannot_parent_itself

  before_validation :set_slug
  before_save :set_position

  scope :top_level, order(:title).where(parent_id: nil, is_home_page: false)

  def slug_path
    "/#{slug}"
  end

  def self.default_home_page
    where(is_home_page: true).first || new(body: '')
  end

  def name
    self.title
  end

  private
  def set_slug
    self.slug ||= self.title.parameterize
  end

  def set_position
    self.move_to_bottom unless self.position
  end

  def cannot_parent_itself
    if self.id && self.id == self.parent_id
      errors.add(:parent_id, "cannot be own parent")
    end
  end
end
