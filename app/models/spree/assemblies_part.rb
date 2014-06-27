module Spree
  class AssembliesPart < ActiveRecord::Base
    belongs_to :assembly, :class_name => "Spree::Product", :foreign_key => "assembly_id"
    belongs_to :part, :class_name => "Spree::Variant", :foreign_key => "part_id"

    def self.get(assembly_id, part_id)
      find_or_initialize_by(assembly_id: assembly_id, part_id: part_id)
    end

    def available_count
      part.total_on_hand / count
    end

    def count_by_stock_location
      Hash[part.stock_items.map { |si| [si.stock_location, (si.count_on_hand / count)] }]
    end
  end
end
