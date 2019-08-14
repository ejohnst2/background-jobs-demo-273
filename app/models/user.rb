class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_save :async_update # Run on create & update

  private

  def async_update
    ThankYouJob.set(wait_until: Date.tomorrow.noon).perform_later
  end
end
