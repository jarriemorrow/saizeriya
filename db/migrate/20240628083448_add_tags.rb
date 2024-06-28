class AddTags < ActiveRecord::Migration[7.0]
  def change
    Tag.create(name: 'アレンジ')
    Tag.create(name: 'ペアリング')
    Tag.create(name: 'コース')
  end
end
