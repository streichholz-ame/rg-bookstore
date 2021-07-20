require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }

  describe 'GET #show' do
    before do
      get :show, params: { id: book.id }
    end

    it { expect(response).to have_http_status 200 }
  end

  describe 'when routes' do
    it { is_expected.to route(:get, "/books/#{book.id}").to(action: :show, id: book.id) }
  end
end
