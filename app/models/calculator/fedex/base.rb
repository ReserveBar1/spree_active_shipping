class Calculator::Fedex::Base < Calculator::ActiveShipping::Base
  def carrier(config=nil)
    if config == nil # keep the original version with a single configuration working.
      ActiveMerchant::Shipping::FedEx.new(:key => Spree::ActiveShipping::Config[:fedex_key], 
                                         :password => Spree::ActiveShipping::Config[:fedex_password], 
                                         :account => Spree::ActiveShipping::Config[:fedex_account],
                                         :login => Spree::ActiveShipping::Config[:fedex_login])
    else
      # retailer's fedex config gets passed in here above                                    
      ActiveMerchant::Shipping::FedEx.new(:key => config[:key], 
                                          :password => config[:password], 
                                          :account => config[:account],
                                          :login => config[:login])
    end
  end
end
