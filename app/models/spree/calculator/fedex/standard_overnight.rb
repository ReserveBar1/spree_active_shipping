module Spree
  class Calculator::Fedex::StandardOvernight < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.standard_overnight")
    end
    
    def self.service_type
      "STANDARD_OVERNIGHT"
    end
    
  end
end
