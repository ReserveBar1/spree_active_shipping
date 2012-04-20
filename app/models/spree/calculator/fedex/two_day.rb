module Spree
  class Calculator::Fedex::TwoDay < Calculator::Fedex::Base
    def self.description
      I18n.t("fedex.two_day")
    end
    
    def self.service_type
      "FEDEX_2_DAY"
    end
    
  end
end
