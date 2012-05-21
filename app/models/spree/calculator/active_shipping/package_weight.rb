module Spree
  module Calculator::ActiveShipping
    
    # Added for reservebar.com, purpose is to calcuate the weight of the packaging for a given shipment / order
    # Curerntly returns weight in lbs
    class PackageWeight
      def self.for(order)
        # Calculation is based on number of bottles in the order
        number_of_items = order.line_items.map(&:quantity).sum
        package_weight = case number_of_items
          when 1      then 0.71
          when 2      then 1.45
          when 3      then 2.75
          when 4..6   then 3.25
          when 7..9   then 3.8
          when 10..12 then 4.24
          else 4.24
        end
        package_weight
      end
    end
  end
end
