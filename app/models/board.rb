# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
class Board < ApplicationRecord
  belongs_to :user, optional: true #optional: true = belongs_toの外部キーのnilを許可するもの
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :tasks, dependent: :destroy
end
