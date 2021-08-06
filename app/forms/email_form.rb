class EmailForm
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String
  attribute :id, Integer

  validates :id, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
