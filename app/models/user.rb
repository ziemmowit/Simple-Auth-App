class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false

  def name
    begin
      return first_name + ' ' + last_name
    rescue StandardError => e
      return 'unknown'
    end
  end

  def role_name
    role_types[role]
  end

  def role_types
    [:inactive, :admin, :normal]
  end
end
