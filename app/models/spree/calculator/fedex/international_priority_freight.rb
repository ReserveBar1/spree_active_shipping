module Spree
  class Calculator::Fedex::InternationalPriorityFreight < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.intl_priority_freight")
    end
    
    def self.service_type
      "INTERNATIONAL_PRIORITY_FREIGHT"
    end
    
  end
end
