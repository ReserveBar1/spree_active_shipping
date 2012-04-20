module Spree
  class Calculator::Fedex::InternationalEconomy < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.intl_economy")
    end
    
    def self.service_type
      "INTERNATIONAL_ECONOMY"
    end
    
  end
end
