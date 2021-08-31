ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        div I18n.t('admin.users', count: User.count)
        div I18n.t('admin.categories', count: Category.count)
        div I18n.t('admin.authors', count: Author.count)
        div I18n.t('admin.books', count: Book.count)
      end
    end
  end
end
