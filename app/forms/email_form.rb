class EmailForm
  include ActiveModel::Model
  include Virtus

  attribute :email, String
  attribute :user_id, Integer

  validates :user_id, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
