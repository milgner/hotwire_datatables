class AddStatusToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :status, :string
    add_check_constraint :books, "status IN ('read', 'unread')", name: :book_status_check
  end
end
