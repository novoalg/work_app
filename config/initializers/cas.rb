require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://ash.uwec.edu/cas", 
  :validate_url => "https://ash1.uwec.edu:8443/cas/serviceValidate",
  :enable_single_sign_out => true
)
