# We need to require the base class here  to make the asset precompilation work
# otherwise complains that is can't find ActiveShipping::Base
require 'spree/calculator/active_shipping/base'

module Spree
  class Calculator::Ups::Base < Calculator::ActiveShipping::Base
    def carrier
      if Spree::ActiveShipping::Config[:shipper_number].nil?
        ActiveMerchant::Shipping::UPS.new(:login => Spree::ActiveShipping::Config[:ups_login],
                                          :password => Spree::ActiveShipping::Config[:ups_password],
                                          :key => Spree::ActiveShipping::Config[:ups_key],
                                          :test => Spree::ActiveShipping::Config[:test_mode])
      else
        ActiveMerchant::Shipping::UPS.new(:login => Spree::ActiveShipping::Config[:ups_login],
                                          :password => Spree::ActiveShipping::Config[:ups_password],
                                          :key => Spree::ActiveShipping::Config[:ups_key],
                                          :origin_account => Spree::ActiveShipping::Config[:shipper_number],
                                          :test => Spree::ActiveShipping::Config[:test_mode])
      end
    end
    
    def carrier_name
      "UPS"
    end
  end
end
