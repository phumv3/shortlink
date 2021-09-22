module ApiHelper
	def columns_transaction
		{
			"id" => "int",
			"amount"=> "float",
			"transaction_type" => "string",
			"user_id" => "int",
			"account_id" => "int"
		}
	end

	def format_value(value, type)
		case type
		when "int"
			value = value.to_i
		when "float"
			value = value.to_f
		when "string"
			value = value.to_s
		end
		value
	end

	def handle_params(params)
		condition = {}
		check = {:bool => true, :message => ""}
		params.except(:controller, :action, :api).each do |key, value|
			if !columns_transaction.key? (key.to_s)
				check[:bool] = false
				check[:message] = key + " not exist"
				break
			end
			condition[key.to_sym] = format_value(value, columns_transaction[key])
		end
		[condition, check]
	end
end
