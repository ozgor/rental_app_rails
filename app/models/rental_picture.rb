class RentalPicture < ActiveRecord::Base
  belongs_to :rental

  has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :file
end
