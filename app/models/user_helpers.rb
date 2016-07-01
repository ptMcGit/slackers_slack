module UserHelpers
  def filter_phone_number phone_number
    phone_number.gsub(/\D/, "").reverse[0..9].reverse
  end

  def valid_phone_number? phone_number
    phone_number.gsub(/\D/,"").length == 10
  end

  def hash_data data
    Digest::SHA256.hexdigest(data)
  end

end
