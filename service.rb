# encoding: UTF-8
require 'json'
require 'sinatra'

class Responder 
def self.collections_complaints
 [
  { id: 1, name: "Samsung"},
  { id: 2, name: "Canon"}
]
end
def self.currencies_complaints
 [
  { id: 1, name: "$"},
  { id: 2, name: "UAH"},
  { id: 3, name: "Euro"}
]
end 
def self.orders_complaints
[
 {
  id: 1,
  address: {  # ассоциация
      first_name: 12312,
      last_name: "koko",
      address: "",
      city: "",
      zipcode: "",
      state: "",
      country: "",
      phone: "",
      alternative_phone: ""
    },
  products:[{  # order_items.includes :product
      id:11,
      name:"",
      price:11,
      currency_id:11,
      quantity:2
  }],
  state: "new",
  total: 11,
  details: "koko"
}
]
end
def self.products_complaints
 [
 {
  id: 1,
  name: "Canon Mark 2 D5",
  description: "koko",
  currency_id: 1,
  collection_id: 1,
  price: 1000,
  photo: [{url: 'koko'},{url:'koko2'}]
}
]
end
def self.login_success
{status: true, auth_token: Random.rand(1000000)}
end
end

before /.*/ do
  response.headers['Access-Control-Allow-Origin'] = '*'
  content_type :json
end

post '/v1/users/sign_in.json' do
Responder.login_success.to_json
end
get '/v1/orders/1' do
Responder.orders_complaints.to_json
end
# Dynamic routes 
def resource(name)
 eval "get '/v1/#{name}' do; Responder.#{name}_complaints.to_json; end"
end

resource :products
resource :orders
resource :collections
resource :currencies
