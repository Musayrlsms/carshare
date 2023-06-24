class AddDocumentStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :document_status, :integer, default: 0
  end
end
