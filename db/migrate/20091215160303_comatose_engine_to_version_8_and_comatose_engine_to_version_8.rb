class ComatoseEngineToVersion8AndComatoseEngineToVersion8 < ActiveRecord::Migration
  def self.up
    Engines.plugins["comatose_engine"].migrate(8)
    Engines.plugins["comatose_engine"].migrate(8)
  end

  def self.down
    Engines.plugins["comatose_engine"].migrate(0)
    Engines.plugins["comatose_engine"].migrate(0)
  end
end
