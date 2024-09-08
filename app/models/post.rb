class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  scope :active, -> { where(is_active: true, is_featured: false) }
  scope :featured, -> { where(is_active: true, is_featured: true) }
  scope :published, -> { where('published_date <= ?', Date.today) }

  def belongs_to_user(current_id)
    user_id == current_id
  end
end
