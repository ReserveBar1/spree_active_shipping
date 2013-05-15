module Spree
  class Calculator::Fedex::TwoDaySaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.two_day_saturday_delivery")
    end
    
    # The service type on the ship API is not FEDEX_2_DAY_SATURDAY_DELIVERY, but rather FEDEX_2_DAY and a special service requested...
    def self.service_type
      "FEDEX_2_DAY"
    end
    
    def self.saturday_delivery
      true
    end
    
  end
end
