class CreateRejectedMatches < ActiveRecord::Migration
  def change
    create_table :rejected_matches do |t|

      t.timestamps
    end
  end
end
