# We need to require the base class here  to make the asset precompilation work
# otherwise complains that is can't find ActiveShipping::Base
require 'calculator/active_shipping/base'

class Calculator::Usps::Base < Calculator::ActiveShipping::Base
  def carrier
    ActiveMerchant::Shipping::USPS.new(:login => Spree::ActiveShipping::Config[:usps_login])
  end
end
