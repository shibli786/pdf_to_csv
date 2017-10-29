class CreateVariableAnnuityAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :wb_variable_annuity_company_account do |t|
      t.timestamps
    end
  end
end
