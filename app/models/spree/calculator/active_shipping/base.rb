# This is a base calculator for shipping calculations using the ActiveShipping plugin.  It is not intended to be
# instantiated directly.  Create sublcass for each specific shipping method you wish to support instead.
# Digest::MD5 is used for cache_key generation.
require 'digest/md5'
module Spree
  module Calculator::ActiveShipping
    class Base < Calculator
      include ActiveMerchant::Shipping

      # Add an uplift individual to each shipping method
      preference :uplift, :decimal, :default => 0
      
      def self.service_name
        self.description
      end

      def compute(object)
        if object.is_a?(Array)
          order = object.first.order
        elsif object.is_a?(Shipment)
          order = object.order
        else
          order = object
        end

        rate = Spree::ShippingMethod.find(self.calculable_id).price
        rate = rate.to_f + (Spree::ActiveShipping::Config[:handling_fee].to_f || 0.0)
        
        # Add individual uplift (preference is in USD, here we are already dealing with cents)
        rate += preferred_uplift.to_f
        
        # Add product based surcharges for the shipping
        rate += order.shipping_surcharge if order.shipping_surcharge.present?
      end

      def timing(line_items)
        order = line_items.first.order
        # Each retailer has his own shipping location, so we need to get the retailer's address to calcuate shipping fees
        origin_address = order.retailer.physical_address
        origin = Location.new(
          :country => origin_address.country.iso, 
          :city => origin_address.city,
          :state => origin_address.state.abbr,
          :zip => origin_address.zipcode
        )

        addr = order.ship_address
        destination = Location.new(
          :country => addr.country.iso,
          :state => (addr.state ? addr.state.abbr : addr.state_name),
          :city => addr.city,
          :zip => addr.zipcode
        )

        timings = Rails.cache.fetch(cache_key(line_items)+"-timings") do
          timings = retrieve_timings(origin, destination, packages(order), order.retailer.shipping_config)
        end

        return nil if timings.nil? || !timings.is_a?(Hash) || timings.empty?
        return timings[self.description]
      end

      private

      def retrieve_rates(origin, destination, packages, config = nil)
        begin
          response = carrier(config).find_rates(origin, destination, packages)
          # turn this beastly array into a nice little hash
          rate_hash = Hash[*response.rates.collect { |rate| [rate.service_name, rate.price] }.flatten]
          return rate_hash
        rescue ActiveMerchant::ActiveMerchantError => e
          if [ActiveMerchant::ResponseError, ActiveMerchant::Shipping::ResponseError].include? e.class
            params = e.response.params
            if params.has_key?("Response") && params["Response"].has_key?("Error") && params["Response"]["Error"].has_key?("ErrorDescription")
              message = params["Response"]["Error"]["ErrorDescription"]
            else
              message = e.message
            end
          else
            message = e.to_s
          end
          Rails.cache.write @cache_key, {} #write empty hash to cache to prevent constant re-lookups
          raise Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
        end
      end

      def retrieve_timings(origin, destination, packages, config = nil)
        begin
          if carrier(config).respond_to?(:find_time_in_transit)
            response = carrier(config).find_time_in_transit(origin, destination, packages)
            return response
          end
        rescue ActiveMerchant::Shipping::ResponseError => re
          params = re.response.params
          if params.has_key?("Response") && params["Response"].has_key?("Error") && params["Response"]["Error"].has_key?("ErrorDescription")
            message = params["Response"]["Error"]["ErrorDescription"]
          else
            message = re.message
          end
          Rails.cache.write @cache_key+'-', {} #write empty hash to cache to prevent constant re-lookups
          raise Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
        end
      end

      # Generates an array of Package objects based on the quantities and weights of the variants in the line items
      def packages(order)
        multiplier = Spree::ActiveShipping::Config[:unit_multiplier]
        weight = order.line_items.inject(0) do |weight, line_item|
          weight + (line_item.variant.weight ? (line_item.quantity * line_item.variant.weight * multiplier) : Spree::ActiveShipping::Config[:default_weight])
        end
        # add the gift packaging weight - if any
        gift_packaging_weight = order.line_items.inject(0) do |gift_packaging_weight, line_item|
          gift_packaging_weight + (line_item.gift_package ? (line_item.quantity * line_item.gift_package.weight * multiplier) : 0.0)
        end
        # Caclulate weight of packaging
        package_weight = Spree::Calculator::ActiveShipping::PackageWeight.for(order)
        
        # Round up the weight to the nearest lbs, like Fedex does in their calculations. At this point, the weight is on oz (due to the setting of unit_mlutiplier)
        total_weight = ((weight + gift_packaging_weight + package_weight) / multiplier).ceil * multiplier
        
        package = Package.new(total_weight, [], :units => Spree::ActiveShipping::Config[:units].to_sym)
        [package]
      end

      def cache_key(order)
        addr = order.ship_address
        carrier_name = carrier(order.retailer.shipping_config)
        line_items_hash = Digest::MD5.hexdigest(order.line_items.map {|li| li.variant_id.to_s + "_" + li.quantity.to_s }.join("|"))
        @cache_key = "#{carrier_name}-#{order.number}-#{addr.country.iso}-#{addr.state ? addr.state.abbr : addr.state_name}-#{addr.city}-#{addr.zipcode}-#{line_items_hash}".gsub(" ","")
      end
    end
  end
end
