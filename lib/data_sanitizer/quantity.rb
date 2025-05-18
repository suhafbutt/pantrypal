module DataSanitizer
  class Quantity
    def self.parse_quantity(quantity_text)
      return nil unless quantity_text.present?

      normalized = quantity_text.gsub(/[½⅓⅔¼¾⅛⅜⅝⅞]/, {
        "½" => "0.5", "⅓" => "0.333", "⅔" => "0.667",
        "¼" => "0.25", "¾" => "0.75", "⅛" => "0.125",
        "⅜" => "0.375", "⅝" => "0.625", "⅞" => "0.875"
      })

      parts = normalized.strip.split
      total = 0.0

      parts.each do |part|
        if part.include?("/")
          numerator, denominator = part.split("/")
          if numerator && denominator
            total += numerator.to_f / denominator.to_f
          end
        else
          total += Float(part) rescue 0
        end
      end

      total > 0 ? total : nil
    end
  end
end
