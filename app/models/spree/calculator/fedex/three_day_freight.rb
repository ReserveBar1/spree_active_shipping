module Spree
  class Calculator::Fedex::ThreeDayFreight < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.three_day_freight")
    end
    
    def self.service_type
      "FEDEX_3_DAY_FREIGHT"
    end
    
  end
end
