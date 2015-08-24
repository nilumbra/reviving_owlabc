class AddPdfToUnits < ActiveRecord::Migration
  def self.up
    add_attachment :units, :pdf
  end

  def self.down
    remove_attachment :units, :pdf
  end
end
