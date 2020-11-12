# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  name                   :string           default(""), not null
#  phone                  :string           default(""), not null
#  website                :string           default(""), not null
#  job_title              :string           default(""), not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  has_friendship
  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  has_many :inquiries, inverse_of: :user, dependent: :destroy
  has_many :quotes, inverse_of: :user, dependent: :destroy

  has_many :friended_users, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :frienders, through: :friended_users
  has_many :friender_users, foreign_key: :friendable_id, class_name: 'Friendship'
  has_many :friendeds, through: :friender_users
  has_many :requested_users, foreign_key: :requested_id, class_name: 'FriendRequest'
  has_many :requesters, through: :requested_users
  has_many :requester_users, foreign_key: :requester_id, class_name: 'FriendRequest'
  has_many :requesteds, through: :requester_users
  has_one_attached :profile_picture

  #chat
  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  #Validations


  # methods
  def friend_request(user)
    FriendRequest.create(requester: self, requested: user)
  end

  def accept_request(user)
    FriendRequest.find_by(requested: self, requester: user).destroy
    Friendship.create(friended: self, friender: user)
  end

  def cancel_request(user)
    FriendRequest.find_by(requester: self, requested: user).destroy
  end

  def reject_request(user)
    FriendRequest.find_by(requester: user, requested: self).destroy
  end

  def remove_friend(user)
    Friendship.where(' (friendable_id = ? AND friend_id = ?) OR (friendable_id = ? AND friend_id = ?)',self.id, user.id, user.id, self.id).first.destroy
  end

  def strangers
    users = []
    User.all.each do |user|

      if(self.friends_with?(user) != true &&
          self != user &&
          self.isFriend(user).exists? != true &&
          self.requester_users.find_by(requested_id: user.id) == nil)
        users << user
      end
    end
    users.to(5)
  end

  def my_friends
    Friendship.where('friendable_id = ? OR friend_id = ?', self.id, self.id)
  end

  def isFriend(user)
    @friends = self.my_friends
    @friends.where('friendable_id = ? OR friend_id = ?', user.id, user.id)
  end

  def get_friend_users
    Friendship.includes(:friended, :friender).where('friendable_id = ? OR friend_id = ?', self.id, self.id)
  end
end
