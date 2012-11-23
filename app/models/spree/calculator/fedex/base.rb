# We need to require the base class here  to make the asset precompilation work
# otherwise complains that is can't find ActiveShipping::Base
require 'spree/calculator/active_shipping/base'

module Spree
  class Calculator::Fedex::Base < Calculator::ActiveShipping::Base
    def carrier(config=nil)
      if config == nil # keep the original version with a single configuration working.
        ActiveMerchant::Shipping::FedEx.new(:key => Spree::ActiveShipping::Config[:fedex_key], 
                                           :password => Spree::ActiveShipping::Config[:fedex_password], 
                                           :account => Spree::ActiveShipping::Config[:fedex_account],
                                           :login => Spree::ActiveShipping::Config[:fedex_login],
                                           :test => Spree::ActiveShipping::Config[:test_mode])
      else
        # retailer's fedex config gets passed in here above  
        ActiveMerchant::Shipping::FedEx.new(config)
      end
    end
    
    # Override in sub class to provide service type for Fedex ship requests
    def self.service_type
      ""
    end
    
    # Override this method to allow passing of options, e.g. for the adult signature
    private
     def retrieve_rates(origin, destination, packages, config = nil, options = nil)
       begin
         response = carrier(config).find_rates(origin, destination, packages, options)
         # turn this beastly array into a nice little hash
         rate_hash = Hash[*response.rates.collect { |rate| [rate.service_name, rate.price] }.flatten]
         return rate_hash
       rescue ActiveMerchant::ActiveMerchantError => e

         if [ActiveMerchant::ResponseError, ActiveMerchant::Shipping::ResponseError].include? e.class
           # catch the case of the Net::Http Bad response case
           if e.response.respond_to? :params
             params = e.response.params
             if params.has_key?("Response") && params["Response"].has_key?("Error") && params["Response"]["Error"].has_key?("ErrorDescription")
               message = params["Response"]["Error"]["ErrorDescription"]
             else
               message = e.message
             end
           else
             message = "We could not retrieve shipping rates, please try again."
           end
         else
           message = e.to_s
         end

         Rails.cache.write @cache_key, {} #write empty hash to cache to prevent constant re-lookups

         raise Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
       end

     end
    
  end
end