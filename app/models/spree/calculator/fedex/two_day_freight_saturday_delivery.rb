module Spree
  class Calculator::Fedex::TwoDayFreightSaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.two_day_freight_saturday_delivery")
    end
    
    def self.service_type
      "FEDEX_2_DAY_FREIGHT_SATURDAY_DELIVERY"
    end
    
  end
end
