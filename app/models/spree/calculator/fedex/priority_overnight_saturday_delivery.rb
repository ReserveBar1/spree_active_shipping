module Spree
  class Calculator::Fedex::PriorityOvernightSaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.priority_overnight_saturday_delivery")
    end
    
    def self.service_type
      "PRIORITY_OVERNIGHT_SATURDAY_DELIVERY"
    end
    
  end
end
