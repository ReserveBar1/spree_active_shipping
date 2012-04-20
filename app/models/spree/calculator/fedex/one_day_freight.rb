module Spree
  class Calculator::Fedex::OneDayFreight < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.one_day_freight")
    end
    
    def self.service_type
      "FEDEX_1_DAY_FREIGHT"
    end
  end
end
