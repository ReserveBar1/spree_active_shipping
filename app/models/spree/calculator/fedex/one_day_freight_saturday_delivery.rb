module Spree
  class Calculator::Fedex::OneDayFreightSaturdayDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.one_day_freight_saturday_delivery")
    end
    
    def self.service_type
      "FEDEX_1_DAY_FREIGHT_SATURDAY_DELIVERY"
    end
  end
end
