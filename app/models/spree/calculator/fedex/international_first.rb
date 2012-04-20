module Spree
  class Calculator::Fedex::InternationalFirst < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.intl_first")
    end
    
    def self.service_type
      "INTERNATIONAL_FIRST"
    end
    
  end
end
