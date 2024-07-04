func convert_to_js(data):
	var data_type = typeof(data)
	
	match data_type:
		TYPE_DICTIONARY:
			var js_object = JavaScript.create_object("Object")
			
			for key in data:
				js_object[key] = convert_to_js(data[key])
			
			return js_object
		
		TYPE_ARRAY:
			var js_array = JavaScript.create_object("Array")
			
			for i in range(data.size()):
				js_array[i] = convert_to_js(data[i])
			
			return js_array
		
		TYPE_STRING:
			return data
		
		TYPE_BOOL:
			return data
		
		TYPE_INT:
			return data
	
	return null
