module Spree
  class Calculator::Fedex::InternationalPriority < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.intl_priority")
    end
    
    def self.service_type
      "INTERNATIONAL_PRIORITY"
    end
    
  end
end
