require 'rails_helper'
require 'capybara/active_admin/rspec'

describe Admin::AuthorsController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin) { create(:admin_user) }
  let!(:author) { create(:author) }
  let(:valid_attributes) { attributes_for(:author) }
  let(:invalid_attributes) { attributes_for(:author, first_name: '') }
  before { sign_in admin }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'assigns the author' do
      get :index
      expect(assigns(:authors)).to include(author)
    end
    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(author.first_name)
    end

    context 'filters' do
      let(:filters_sidebar) { page.find('#filters_sidebar_section') }
      let(:matching_author) { create(:author, first_name: 'John') }
      let(:non_matching_author) { create(:author, first_name: 'Doe') }

      it 'filter first_Name exists' do
        get :index
        expect(filters_sidebar).to have_css('label[for="q_first_name"]', text: 'First name')
        expect(filters_sidebar).to have_css('input[name="q[first_name_contains]"]')
      end

      it 'filter first_Name works' do
        get :index, params: { q: { first_name_contains: 'John' } }
        expect(assigns(:authors)).to include(matching_author)
        expect(assigns(:authors)).not_to include(non_matching_author)
      end
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the author' do
      get :new
      expect(assigns(:author)).to be_a_new(Author)
    end
    it 'should render the form elements' do
      get :new
      expect(page).to have_field('First name')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new author' do
        expect do
          post :create, params: { author: valid_attributes }
        end.to change(Author, :count).by(1)
      end

      it 'assigns a newly created author as @author' do
        post :create, params: { author: valid_attributes }
        expect(assigns(:author)).to be_a(Author)
        expect(assigns(:author)).to be_persisted
      end

      it 'redirects to the created author' do
        post :create, params: { author: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_author_path(Author.last))
      end

      it 'should create the author' do
        post :create, params: { author: valid_attributes }
        author = Author.last

        expect(author.first_name).to eq(valid_attributes[:first_name])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { author: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved author as @author' do
        post :create, params: { author: invalid_attributes }
        expect(assigns(:author)).to be_a_new(Author)
      end

      it 'invalid_attributes do not create a author' do
        expect do
          post :create, params: { author: invalid_attributes }
        end.not_to change(Author, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: author.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the author' do
      expect(assigns(:author)).to eq(author)
    end
    it 'should render the form elements' do
      expect(page).to have_field('First name', with: author.first_name)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: author.id, author: valid_attributes }
      end
      it 'assigns the author' do
        expect(assigns(:author)).to eq(author)
      end
      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_author_path(author))
      end
      it 'should update the author' do
        author.reload

        expect(author.first_name).to eq(valid_attributes[:first_name])
      end
    end
    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: author.id, author: invalid_attributes }
        expect(response).to have_http_status(:success)
      end
      it 'does not change author' do
        expect do
          put :update, params: { id: author.id, author: invalid_attributes }
        end.not_to change { author.reload.first_name }
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: author.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the author' do
      expect(assigns(:author)).to eq(author)
    end
    it 'should render the form elements' do
      expect(page).to have_content(author.first_name)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: author.id }
      end.to change(Author, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: author.id }
      expect(response).to redirect_to(admin_authors_path)
    end
  end
end
