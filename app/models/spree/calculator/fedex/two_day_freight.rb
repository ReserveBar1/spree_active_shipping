module Spree
  class Calculator::Fedex::TwoDayFreight < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.two_day_freight")
    end
    
    def self.service_type
      "FEDEX_2_DAY_FREIGHT"
    end
    
  end
end
