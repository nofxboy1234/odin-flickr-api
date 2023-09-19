class CreateStaticPages < ActiveRecord::Migration[7.0]
  def change
    create_table :static_pages do |t|
      t.string :flickr_id

      t.timestamps
    end
  end
end
