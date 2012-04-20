module Spree
  class Calculator::Fedex::ThreeDayFreightSaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.three_day_freight_saturday_delivery")
    end
    
    def self.service_type
      "FEDEX_3_DAY_FREIGHT_SATURDAY_DELIVERY"
    end
    
  end
end
