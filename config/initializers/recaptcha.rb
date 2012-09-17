Recaptcha.configure do |config|

  if Rails.env.development?
    config.public_key  = '6Ldxc9YSAAAAAKdPhQ-RDY1XkWwzREtkR0PS9cgX'
    config.private_key = '6Ldxc9YSAAAAAK0Ts6sBT2oQFKjmKPBVT0UKTgks'
  else
    config.public_key  = '6LcPydMSAAAAAFDmqKVbkjFAMAUCFre98lNPwsuo'
    config.private_key = '6LcPydMSAAAAAMAvCCQ3UOVKLSDGEzm_T4AySMIyx'
  end
  #config.proxy = 'http://myproxy.com.au:8080'
end