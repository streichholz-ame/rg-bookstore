require 'rails_helper'
require 'capybara/active_admin/rspec'

describe Admin::ReviewsController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin) { create(:admin_user) }
  let!(:review) { create(:review) }
  before { sign_in admin }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'assigns the author' do
      get :index
      expect(assigns(:reviews)).to include(review)
    end
    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(review.review_text)
    end

    context 'filters' do
      let(:filters_sidebar) { page.find('#filters_sidebar_section') }
      let(:matching_book) { create(:review, book: 'book') }
      let(:non_matching_book) { create(:review, book: 'other') }

      it 'filter first_Name exists' do
        get :index
        expect(filters_sidebar).to have_css('label[for="q_book_id"]', text: 'Book')
        expect(filters_sidebar).to have_css('select[name="q[book_id_eq]"]')
      end
    end
  end
end
