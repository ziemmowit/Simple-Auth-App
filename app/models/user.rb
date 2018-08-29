class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :role, presence: true, allow_blank: false

  def name
    begin
      return first_name + ' ' + last_name
    rescue StandardError => e
      return 'unknown'
    end
  end

  def role_name
    role < role_types.count ? role_types[role] : role_types[2]
  end

  private

def role_types
    [:inactive, :admin, :normal]
  end
end
