class AddLastMatchedTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_matched_time, :datetime
  end
end
