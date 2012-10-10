class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :title

      t.timestamps
    end
    add_index :movies, :title
  end
end
