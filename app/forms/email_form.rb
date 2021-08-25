class EmailForm
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
