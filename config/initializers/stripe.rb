Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}


Stripe.set_app_info(
  'moc-moc',
  version: '0.0.1',
  url: 'http://localhost:3000/'
)
Stripe.api_version = '2022-11-15'
Stripe.api_key = ENV['STRIPE_SECRET_KEY']