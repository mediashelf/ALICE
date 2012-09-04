class AddIsHomePagetoPages < ActiveRecord::Migration
  def change
    add_column :pages, :is_home_page, :boolean, { default: false }
  end
end
