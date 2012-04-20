module Spree
  class Calculator::Fedex::InternationalEconomyFreight < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.intl_economy_freight")
    end
    
    def self.service_type
      "INTERNATIONAL_ECONOMY_FREIGHT"
    end
    
  end
end
