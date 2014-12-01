# module Infuseit
#   module Request
#
#     def get service_call, *args
#       request :get, service_call, *args
#     end
#
#     def post path, params = {}, options = {}
#       request :post, path, params, options
#     end
#
#     def put path, params = {}, options = {}
#       request :put, path, params, options
#     end
#
#     def delete path, params = {}, options = {}
#       request :delete, path, params, options
#     end
#
#
#     private
#
#     def request method, service_call, *args
#       case method.to_sym
#       when :get
#         response = connection service_call, *args
#       end
#     end
#
#   end
# end
