class Calculator::Fedex::Base < Calculator::ActiveShipping::Base
  def carrier(config)
    if config == nil # keep the original version with a single configuration working.
      ActiveMerchant::Shipping::FedEx.new(:key => Spree::ActiveShipping::Config[:fedex_key], 
                                         :password => Spree::ActiveShipping::Config[:fedex_password], 
                                         :account => Spree::ActiveShipping::Config[:fedex_account],
                                         :login => Spree::ActiveShipping::Config[:fedex_login])
    else
      # retailer's fedex config gets passed in here above                                    
      ActiveMerchant::Shipping::FedEx.new(:key => config[:fedex_key], 
                                          :password => config[:fedex_password], 
                                          :account => config[:fedex_account],
                                          :login => config[:fedex_login])
    end
  end
end
