module Spree
  class Calculator::Fedex::GroundHomeDelivery < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.ground_home_delivery")
    end
    
    def self.service_type
      "GROUND_HOME_DELIVERY"
    end
  end
end
