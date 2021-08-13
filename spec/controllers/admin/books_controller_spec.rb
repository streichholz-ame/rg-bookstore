require 'rails_helper'
require 'capybara/active_admin/rspec'

describe Admin::BooksController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin) { create(:admin_user) }
  let(:category) { create(:category) }
  let!(:book) { create(:book, category: category) }
  let(:valid_attributes) { attributes_for(:book, category_id: category.id) }
  let(:invalid_attributes) { attributes_for(:book, name: '') }
  before { sign_in admin }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'assigns the book' do
      get :index
      expect(assigns(:books)).to include(book)
    end
    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(book.name)
    end

    context 'filters' do
      let(:filters_sidebar) { page.find('#filters_sidebar_section') }
      let(:matching_book) { create(:book, name: 'Book') }
      let(:non_matching_book) { create(:book, name: 'Design') }

      it 'filter Name exists' do
        get :index
        expect(filters_sidebar).to have_css('label[for="q_name"]', text: 'Name')
        expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
      end

      it 'filter Name works' do
        get :index, params: { q: { name_contains: 'Book' } }
        expect(assigns(:books)).not_to include(non_matching_book)
      end
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the book' do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
    it 'should render the form elements' do
      get :new
      expect(page).to have_field('Name')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new book' do
        expect do
          post :create, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)
      end

      it 'assigns a newly created book as @book' do
        post :create, params: { book: valid_attributes }
        expect(assigns(:book)).to be_a(Book)
        expect(assigns(:book)).to be_persisted
      end

      it 'redirects to the created book' do
        post :create, params: { book: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_book_path(Book.last))
      end

      it 'should create the book' do
        post :create, params: { book: valid_attributes }
        book = Book.last

        expect(book.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { book: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved book as @book' do
        post :create, params: { book: invalid_attributes }
        expect(assigns(:book)).to be_a_new(Book)
      end

      it 'invalid_attributes do not create a book' do
        expect do
          post :create, params: { book: invalid_attributes }
        end.not_to change(Book, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: book.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the person' do
      expect(assigns(:book)).to eq(book)
    end
    it 'should render the form elements' do
      expect(page).to have_field('Name', with: book.name)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: book.id, book: valid_attributes }
      end
      it 'assigns the book' do
        expect(assigns(:book)).to eq(book)
      end
      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_book_path(book))
      end
      it 'should update the book' do
        book.reload

        expect(book.name).to eq(valid_attributes[:name])
      end
    end
    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: book.id, book: invalid_attributes }
        expect(response).to have_http_status(:success)
      end
      it 'does not change book' do
        expect do
          put :update, params: { id: book.id, book: invalid_attributes }
        end.not_to change { book.reload.name }
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: book.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the book' do
      expect(assigns(:book)).to eq(book)
    end
    it 'should render the form elements' do
      expect(page).to have_content(book.name)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: book.id }
      end.to change(Book, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(admin_books_path)
    end
  end
end
