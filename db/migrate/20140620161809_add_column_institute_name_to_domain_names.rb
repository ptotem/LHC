class AddColumnInstituteNameToDomainNames < ActiveRecord::Migration
  def change
    add_column :domain_names, :institute_name, :string
  end
end
