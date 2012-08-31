class Page < ActiveRecord::Base
  attr_accessible :title, :body, :position, :parent_id, :slug

  has_many :children, class_name: Page, foreign_key: 'parent_id'
  belongs_to :parent, class_name: Page

  validates :title, :body, :slug, presence: true
  validate :cannot_parent_itself

  before_validation :set_slug

  def slug_path
    "/#{slug}"
  end

  private
  def set_slug
    self.slug ||= self.title.parameterize
  end

  def cannot_parent_itself
    if self.id && self.id == self.parent_id
      errors.add(:parent_id, "cannot be own parent")
    end
  end
end
