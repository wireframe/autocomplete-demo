class CreateMovies < ActiveRecord::Migration
  def change
    # File.open("/Users/ryan/Downloads/movies.list", 'r').each_line do |l| puts l end
    create_table :movies do |t|
      t.text :title

      t.timestamps
    end
    add_index :movies, :title
  end
end
