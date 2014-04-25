class CreateSiteContents < ActiveRecord::Migration
  def change
    create_table :site_contents do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
