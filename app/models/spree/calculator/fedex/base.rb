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
  end
end