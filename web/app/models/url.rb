class Url < ApplicationRecord
  UNIQUE_ID_LENGTH = 6 # Độ dài của bộ mã
  ORIGINAL_VALID_FORMAT = /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,512}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/  # Regex cho link nhập
  before_create :generate_short_url
  belongs_to :user
  validates :long_url , presence: true, length: { minimum: 3, maximum: 256}, format:{with:ORIGINAL_VALID_FORMAT,multiline:true}
  
  def generate_short_url
    url = ([*("a".."z"),*("0".."9")]).sample(UNIQUE_ID_LENGTH).join
    long_url = Url.where(short_url: url).last
    if long_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end
end
