class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :confirmable

         #Removed :database_authenticatable,

end
