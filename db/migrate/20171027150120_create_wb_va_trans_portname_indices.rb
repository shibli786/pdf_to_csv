class CreateWbVaTransPortnameIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :wb_va_trans_portname_indices do |t|
    	t.string :name
    	t.boolean :status
    	t.datetime :last_date_updated
    	t.text :comment
      	t.timestamps
    end
  end
end
