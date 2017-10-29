class AddFullTextSearchOnName < ActiveRecord::Migration[5.0]
  def change
  	execute "ALTER TABLE wb_va_trans_portname_indices ADD FULLTEXT(name)"
  end
end
