class AddAddressZipcodeLevelToProfiles < ActiveRecord::Migration
  def change
    add_column  :profiles, :address,  :string
    add_column  :profiles, :zip_code, :string
    add_column  :profiles, :level,    :string, :default => 'None'
  end
end
