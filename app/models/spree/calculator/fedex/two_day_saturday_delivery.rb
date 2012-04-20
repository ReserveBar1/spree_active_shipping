module Spree
  class Calculator::Fedex::TwoDaySaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.two_day_saturday_delivery")
    end
    
    def self.service_type
      "FEDEX_2_DAY_SATURDAY_DELIVERY"
    end
    
  end
end
