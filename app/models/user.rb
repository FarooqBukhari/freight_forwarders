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
  acts_as_reader
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
  has_many :quotes_received, through: :inquiries, source: :quotes
  has_many :quoted_inquiry, through: :quotes, source: :inquiry

  has_many :friended_users, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :frienders, through: :friended_users
  has_many :friender_users, foreign_key: :friendable_id, class_name: 'Friendship'
  has_many :friendeds, through: :friender_users
  has_many :requested_users, foreign_key: :requested_id, class_name: 'FriendRequest'
  has_many :requesters, through: :requested_users
  has_many :requester_users, foreign_key: :requester_id, class_name: 'FriendRequest'
  has_many :requesteds, through: :requester_users
  has_one_attached :profile_picture
  has_one_attached :cover_photo

  #chat
  has_many :conversations, foreign_key: :sender_id
  has_many :messages, through: :conversations
  #Validations
  validates :email, email: true
  validates_presence_of :name, on: :update
  validates_presence_of :company_name, on: :update
  validates_presence_of :job_title, on: :update
  validates_presence_of :country, on: :update
  validates_presence_of :phone, on: :update

  # methods

  def initials
    splitted = self.name.split
    if splitted.length > 1
      fname, l_name = splitted[0], splitted[1]
    else
      fname = splitted[0]
    end
    return (fname[0] + (l_name.present? ? l_name[0] : '')).upcase
  end


  def friend_request(user)
    FriendRequest.create(requester: self, requested: user)
  end

  def accept_request(user)
    FriendRequest.where(requested_id: self.id, requester_id: user.id).destroy_all
    Friendship.create(friended: self, friender: user)
  end

  def cancel_request(user)
    FriendRequest.find_by(requester: self, requested: user).destroy
  end

  def reject_request(user)
    FriendRequest.find_by(requester: user, requested: self).destroy
  end

  def remove_friend(user)
    Friendship.where(' (friendable_id = ? AND friend_id = ?) OR (friendable_id = ? AND friend_id = ?)',id, user.id, user.id, id).first.destroy
  end

  def strangers
    users = []
    User.all.each do |user|

      if(friends_with?(user) != true &&
          self != user &&
          isFriend(user).exists? != true &&
          requester_users.find_by(requested_id: user.id) == nil)
        users << user
      end
    end
    users.sample(5)
  end

  def my_friends
    Friendship.where('friendable_id = ? OR friend_id = ?', id, id)
  end

  def isFriend(user)
    @friends = my_friends
    @friends.where('friendable_id = ? OR friend_id = ?', user.id, user.id)
  end

  def get_friend_users
    Friendship.includes(:friended, :friender).where('friendable_id = ? OR friend_id = ?', id, id)
  end

  def get_friends_users_array
    users = []
    get_friend_users.each do |friendship|
      users << friendship.other_user(self)
    end
    users
  end

  def friendships
    Friendship.where("friendable_id = ? OR friend_id = ?", id, id)
  end

  def all_conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  def unread_messages_count
    all = []
    count = 0
    all_conversations.each do |convo|
      convo.messages.each do |msg|
        if msg.user_id != id
          all << msg
        end
      end
    end
    all.each do |msg|
      if msg.unread?(self)
        count+=1
      end
    end
    count
  end


  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end
end
