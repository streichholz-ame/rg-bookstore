require 'rails_helper'
require 'capybara/active_admin/rspec'

describe Admin::CategoriesController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin) { create(:admin_user) }
  let!(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:category) }
  let(:invalid_attributes) { attributes_for(:category, name: '') }
  before { sign_in admin }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'assigns the category' do
      get :index
      expect(assigns(:categories)).to include(category)
    end
    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(category.name)
    end

    context 'filters' do
      let(:filters_sidebar) { page.find('#filters_sidebar_section') }
      let(:matching_category) { create(:category, name: 'Web') }
      let(:non_matching_category) { create(:category, name: 'Design') }

      it 'filter Name exists' do
        get :index
        expect(filters_sidebar).to have_css('label[for="q_name"]', text: 'Name')
        expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
      end

      it 'filter Name works' do
        get :index, params: { q: { name_contains: 'Web' } }
        expect(assigns(:categories)).to include(matching_category)
        expect(assigns(:categories)).not_to include(non_matching_category)
      end
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
    it 'should render the form elements' do
      get :new
      expect(page).to have_field('Name')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new Category' do
        expect do
          post :create, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'assigns a newly created category as @category' do
        post :create, params: { category: valid_attributes }
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the created category' do
        post :create, params: { category: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_category_path(Category.last))
      end

      it 'should create the category' do
        post :create, params: { category: valid_attributes }
        category = Category.last

        expect(category.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved category as @category' do
        post :create, params: { category: invalid_attributes }
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 'invalid_attributes do not create a category' do
        expect do
          post :create, params: { category: invalid_attributes }
        end.not_to change(Category, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: category.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the person' do
      expect(assigns(:category)).to eq(category)
    end
    it 'should render the form elements' do
      expect(page).to have_field('Name', with: category.name)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: category.id, category: valid_attributes }
      end
      it 'assigns the category' do
        expect(assigns(:category)).to eq(category)
      end
      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_category_path(category))
      end
      it 'should update the category' do
        category.reload

        expect(category.name).to eq(valid_attributes[:name])
      end
    end
    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: category.id, category: invalid_attributes }
        expect(response).to have_http_status(:success)
      end
      it 'does not change category' do
        expect do
          put :update, params: { id: category.id, category: invalid_attributes }
        end.not_to change { category.reload.name }
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: category.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the category' do
      expect(assigns(:category)).to eq(category)
    end
    it 'should render the form elements' do
      expect(page).to have_content(category.name)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to(admin_categories_path)
    end
  end
end
