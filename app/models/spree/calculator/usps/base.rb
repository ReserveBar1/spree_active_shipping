# We need to require the base class here  to make the asset precompilation work
# otherwise complains that is can't find ActiveShipping::Base
require 'spree/calculator/active_shipping/base'

module Spree
  class Calculator::Usps::Base < Calculator::ActiveShipping::Base
    def carrier
      ActiveMerchant::Shipping::USPS.new( :login => Spree::ActiveShipping::Config[:usps_login],
                                          :test => Spree::ActiveShipping::Config[:test_mode])
    end
    
    def carrier_name
      "USPS"
    end
  end
end
