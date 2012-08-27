module Spree
  class Calculator::Fedex::InternationalPrioritySaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.intl_priority_saturday_delivery")
    end
    
    def self.service_type
      "INTERNATIONAL_PRIORITY_SATURDAY_DELIVERY"
    end
      
  end
end
